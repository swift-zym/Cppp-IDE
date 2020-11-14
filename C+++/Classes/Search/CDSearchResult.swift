//
//  CDSearchResult.swift
//  C+++
//
//  Created by 23786 on 2020/7/27.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDSearchResult: NSObject, SKSyntaxTextViewDelegate {
    
    public init(snippet: CDSnippet) {
        super.init()
        
        self.title = snippet.title
        self.type = .snippet
        self.value = snippet.code
        self.image = snippet.image
        
    }
    
    public init(recentFileUrl url: URL) {
        super.init()
        
        self.title = url.lastPathComponent
        self.type = .recentFiles
        self.value = url.path
        self.image = NSWorkspace.shared.icon(forFile: self.value as! String)
        
    }
    
    public init(helpWithTitle title: String, content: String) {
        super.init()
        
        self.title = title
        self.value = content
        self.image = NSImage(named: "Help")!
        self.type = .help
        
    }
    
    convenience public init(searchInFileForWord word: String) {
        
        self.init(helpWithTitle: "Search for \"\(word)\" in your file", content: "Double-click the button on the left or you can use Command + F.")
        if word == "" {
            self.title = "Search in your file"
        }
        self.type = .fileContent
        self.image = NSImage(named: NSImage.touchBarSearchTemplateName)!
        
    }
    
    func containsKeyword(word: String) -> Bool {
        
        var string = word.trimmingCharacters(in: .whitespaces)
        var type: Type = .none
        if string.hasPrefix("Help:") {
            string = string.replacingOccurrences(of: "Help:", with: "")
            type = .help
        } else if string.hasPrefix("Snippet:") || string.hasPrefix("Code Snippet:") {
            string = string.replacingOccurrences(of: "Code Snippet:", with: "").replacingOccurrences(of: "Snippet:", with: "")
            type = .snippet
        } else if string.hasPrefix("Recent File:") || string.hasPrefix("File:") {
            string = string.replacingOccurrences(of: "Recent File:", with: "").replacingOccurrences(of: "File:", with: "")
            type = .recentFiles
        }
        
        let words = string.components(separatedBy: " ")
        
        if type == .none {
            
            switch self.type {
                
                case .snippet, .recentFiles, .help:
                    for word in words {
                        guard (self.value as! String).contains(word) || self.title.lowercased().contains(word.lowercased()) || word == "" else {
                            return false
                        }
                    }
                    return true
                    
                default: break
                    
            }
            
        } else {
            
            if type != self.type {
                return false
            } else {
                
                switch self.type {
                    
                    case .snippet, .recentFiles, .help:
                        for word in words {
                            guard (self.value as! String).contains(word) || self.title.lowercased().contains(word.lowercased()) || word == "" else {
                                return false
                            }
                        }
                        return true
                        
                    default: break
                        
                }
                
            }
            
        }
        
        return true
    }
    
    
    enum `Type`: Int {
        case none = 0x00
        case snippet = 0x01
        case recentFiles = 0x02
        case fileContent = 0x03
        case help = 0x04
    }
    
    var type: Type = .none
    var title: String = ""
    var value: Any!
    var image: NSImage!
    
    var theme = CDCodeEditorTheme(isDarkMode: false)
    lazy var lexer = CDCppLexer()
    
    func lexerForSource(_ source: String) -> SKLexer {
        return self.lexer
    }
    
    func loadResultDetailInView(view: NSView, isDarkMode: Bool = false) {
        
        switch self.type {
            
            case .snippet:
                let textView = SKSyntaxTextView(frame: view.bounds)
                textView.text = self.value as! String
                textView.delegate = self
                self.theme = isDarkMode ? CDSettings.darkTheme : CDSettings.lightTheme
                textView.theme = self.theme
                view.addSubview(textView)
            
            case .recentFiles:
                let imageView = NSImageView(frame: view.bounds)
                imageView.image = NSWorkspace.shared.icon(forFile: self.value as! String)
                imageView.alignment = .center
                imageView.imageScaling = .scaleProportionallyDown
                view.addSubview(imageView)
                
            case .help, .fileContent:
                let textView = NSTextView(frame: view.bounds)
                textView.string = self.title + "\n\n" + (self.value as! String)
                textView.drawsBackground = false
                textView.font = NSFont.systemFont(ofSize: 16.0, weight: .thin)
                textView.textStorage?.addAttribute(.font, value: NSFont.systemFont(ofSize: 20.0, weight: .bold), range: NSMakeRange(0, self.title.count))
                textView.isEditable = false
                
                let scrollView = NSScrollView(frame: view.bounds)
                scrollView.hasVerticalScroller = true
                scrollView.hasHorizontalScroller = true
                scrollView.drawsBackground = false
                scrollView.documentView = textView
                
                view.addSubview(scrollView)
                
            default: break
                
        }
        
    }
    
}
