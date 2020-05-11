//
//  CDTextView.swift
//  Code Editor
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa


let completion = [
    "(" : ")",
    "[" : "]"
]


extension String {
    
    func challenge(_ input: Character) -> Int {
        var letterCount = 0
        for letter in Array(self) {
            if letter == input {
                letterCount += 1
            }
        }
        return letterCount
    }

}

class CDTextView: NSTextView {

    let highlightr = Highlightr()
    var gutterDelegate: CDTextViewDelegate!
    var scrollView: CDScrollView!
    var codeTextViewDelegate: CDTextViewDelegate!
    var codeAttributedString: CodeAttributedString!
    
    
    // MARK: - Override Functions
    
    /// When the text changes, highlight the text.
    override func didChangeText() {
        
        super.didChangeText()
        
        let a = self.selectedRange
        let code = self.string
        let highlightedCode = highlightr!.highlight(code, as: "C++")
        
        self.textStorage!.setAttributedString(highlightedCode!)
        self.setSelectedRange(a)
        
        self.codeTextViewDelegate?.didChangeText!(lines: self.textStorage?.paragraphs.count ?? 0, characters: self.textStorage?.characters.count ?? 0)
        self.gutterDelegate?.didChangeText!(lines: (self.textStorage?.paragraphs.count)!, characters: 0)
        
    }
    
    /// shouldChangeText(in:replacementString:)
    override func shouldChangeText(in affectedCharRange: NSRange, replacementString: String?) -> Bool {
        
        let superResult = super.shouldChangeText(in: affectedCharRange, replacementString: replacementString)
        
        if let left = replacementString {
            
            if config.AutoComplete == false {
                return superResult
            }
            
            // When Input "{", insert "}".
            if left == "{" {
                self.insertNewline(self)
                self.insertText("\t", replacementRange: self.selectedRange)
                let desRange = self.selectedRange
                self.insertNewline(self)
                self.insertText("}", replacementRange: self.selectedRange)
                self.selectedRange = desRange
                
                return superResult
            }
            
            
            // When input "(", "[", etc, insert "]", ")", etc.
            if let right = completion[left] {
                
                let rangeLocation = self.selectedRange.location
                self.insertText(right, replacementRange: self.selectedRange)
                self.selectedRange.location = rangeLocation
                
                self.didChangeText()
                
            }
            
        }
        return superResult
        
    }
    
    
    /// When press ENTER, insert tabs.
    override func insertNewline(_ sender: Any?) {
        super.insertNewline(sender)
        
        let nsstring = NSString(string: self.string)
        let string = nsstring.substring(to: self.selectedRange.location)
        let l = string.challenge("{")
        let r = string.challenge("}")
        let c = l - r
        if c > 0 {
            for _ in 1...c {
                self.insertText("\t", replacementRange: self.selectedRange)
            }
        }
        
    }
    
    override func completions(forPartialWordRange charRange: NSRange, indexOfSelectedItem index: UnsafeMutablePointer<Int>) -> [String]? {
        
        func compare(_ a: String, _ b: String) -> Int {
            var cnt: Int = 0
            if a.count > b.count {
                return 0
            } else {
                for (index, c) in Array(a).enumerated() {
                    if Array(b)[index] == c {
                        cnt += 1
                    }
                }
            }
            return cnt
        }
        
        var res = [String]()
        let string = (self.string as NSString).substring(with: charRange)
        print("word = \(string) ")
        let parser = CDParser(code: self.string)
        let parserRes = parser.getIdentifiers()
        for i in parserRes {
            if compare(string, i) == string.count {
                res.append(i)
            }
        }
        return res
        
    }
    
    override func complete(_ sender: Any?) {
        
        super.complete(sender)
        
    }
    
    
    // MARK: - init(coder:)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.textContainer?.size = NSSize(width: CGFloat(Int.max), height: CGFloat(Int.max))
        self.textContainer?.widthTracksTextView = false
        
        if let savedData = SettingsViewController.getSavedData() {
            
            config = savedData
            
        } else {
            
            initDefaultData()
            
        }
        
        self.highlightr!.setTheme(to: config.LightThemeName)
        self.highlightr!.theme.setCodeFont(NSFont(name: config.FontName, size: CGFloat(config.FontSize))!)
        
    }
    
}