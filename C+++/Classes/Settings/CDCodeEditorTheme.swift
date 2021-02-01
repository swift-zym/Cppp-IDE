//
//  CDCodeEditorTheme.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCodeEditorTheme: NSObject, SKSourceCodeTheme {
    
    init(isDarkMode: Bool) {
        if isDarkMode {
            self.codeColor = .white
            self.keywordColor = NSColor(red: 167/255, green: 210/255, blue: 1, alpha: 1.0)
            self.currentLineColor = NSColor(red: 35/255, green: 37/255, blue: 43/255, alpha: 1.0)
        } else {
            self.codeColor = .black
            self.keywordColor = NSColor(red: 28/255, green: 171/255, blue: 1, alpha: 1.0)
            self.currentLineColor = NSColor(red: 232/255, green: 242/255, blue: 1, alpha: 1.0)
        }
    }
    
    var font: NSFont {
        return CDSettings.font
    }
    
    var backgroundColor: NSColor = .textBackgroundColor
    
    var codeColor = NSColor.textColor
    var commentColor = NSColor(red: 69.0/255.0, green: 187.0/255.0, blue: 62.0/255.0, alpha: 1.0)
    var numberColor = NSColor(red: 208/255, green: 190/255, blue: 105/255, alpha: 1.0)
    var stringColor = NSColor(red: 237/255, green: 101/255, blue: 90/255, alpha: 1.0)
    var identifierColor = NSColor(red: 177/255, green: 111/255, blue: 253/255, alpha: 1.0)
    var keywordColor = NSColor(red: 100/255, green: 196/255, blue: 250/255, alpha: 1.0)
    var preprocessorColor = NSColor.orange
    var currentLineColor = NSColor.controlHighlightColor
    
    public func color(for syntaxColorType: SKSourceCodeTokenType) -> Color {
        
        switch syntaxColorType {
        case .plain:
            return self.codeColor
            
        case .number:
            return self.numberColor
            
        case .string:
            return self.stringColor
            
        case .identifier:
            return self.identifierColor
            
        case .keyword:
            return self.keywordColor
            
        case .comment:
            return self.commentColor
            
        case .preprocesscor:
            return self.preprocessorColor
            
        case .editorPlaceholder:
            return backgroundColor
        }
        
    }
    
    var dictionaryData: Dictionary<String, String> {
        return [
            "codeColor": self.codeColor.hexString,
            "numberColor": self.numberColor.hexString,
            "stringColor": self.stringColor.hexString,
            "identifierColor": self.identifierColor.hexString,
            "keywordColor": self.keywordColor.hexString,
            "commentColor": self.commentColor.hexString,
            "preprocessorColor": self.preprocessorColor.hexString,
            "currentLineColor": self.currentLineColor.hexString
        ]
    }
    
    init(from dictionary: Dictionary<String, Any>) {
        
        let dict = dictionary as! Dictionary<String, String>
        self.codeColor = NSColor(hexString: dict["codeColor"]!)
        self.numberColor = NSColor(hexString: dict["numberColor"]!)
        self.stringColor = NSColor(hexString: dict["stringColor"]!)
        self.identifierColor = NSColor(hexString: dict["identifierColor"]!)
        self.keywordColor = NSColor(hexString: dict["keywordColor"]!)
        self.commentColor = NSColor(hexString: dict["commentColor"]!)
        self.preprocessorColor = NSColor(hexString: dict["preprocessorColor"]!)
        self.currentLineColor = NSColor(hexString: dict["currentLineColor"]!)
        
    }
    
}
