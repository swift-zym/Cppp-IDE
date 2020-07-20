//
//  CDGraphicalCodeEditorCellView.swift
//  C+++
//
//  Created by 23786 on 2020/7/17.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

protocol CDGraphicalCodeEditorCellViewDelegate {
    
    func codeEditorCellViewDidChangeValue(_ view: CDGraphicalCodeEditorCellView)
    
}

typealias CDGraphicalCodeEditorCellData = Dictionary<String, String>

class CDGraphicalCodeEditorCellView: NSView {
    
    @IBOutlet var lineNumberButton: NSButton!
    @IBOutlet var backgroundTextField: NSTextField!
    var delegate: CDGraphicalCodeEditorCellViewDelegate!
    
    var code: String {
        return ""
    }
    
    var typeName: String {
        return "Universal"
    }
    
    var dictionary: CDGraphicalCodeEditorCellData = [:]
    
    var savedDataKeys: [String] {
        return [String]()
    }
    
    func loadStoredData(string: String) {
        for key in savedDataKeys {
            let first = string.firstIndexOf("<KEY=\(key.uppercased())>")
            let last = string.firstIndexOf("</KEY=\(key.uppercased())>")
            let range = NSMakeRange(first + "<KEY=\(key.uppercased())>".count, last - first - "</KEY=\(key.uppercased())>".count + 1)
            let substring = string.nsString.substring(with: range)
            dictionary[key] = substring
        }
    }
    
    func setLineNumber(_ number: Int) {
        self.lineNumberButton?.title = "\(number)"
    }
    
    var storedData: String {
        var string = CDGraphicalCodeDocument.lineSeparator + "\n" + self.typeName + "\n"
        for (key, value) in self.dictionary {
            string.append("<KEY=\(key.uppercased())>\(value)</KEY=\(key.uppercased())>\n")
        }
        return string
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    func resetIBOutlet() {
        
        for view in subviews {
            if let identifier = view.identifier {
                if identifier.rawValue == "Background" {
                    self.backgroundTextField = view as? NSTextField
                }
                if identifier.rawValue == "LineNumber" {
                    self.lineNumberButton = view as? NSButton
                }
            }
        }
        
    }
    
}