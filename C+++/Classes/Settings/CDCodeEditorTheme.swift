//
//  CDCodeEditorTheme.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCodeEditorTheme: NSObject, SKSourceCodeTheme {
    
    override init() {
        super.init()
    }
    
    var font: NSFont {
        return CDSettings.font
    }
    
    var backgroundColor: NSColor = .textBackgroundColor
    
    var codeColor = NSColor.textColor
    var commentColor = NSColor(red: 69.0/255.0, green: 187.0/255.0, blue: 62.0/255.0, alpha: 1.0)
    var numberColor = NSColor(red: 116/255, green: 109/255, blue: 176/255, alpha: 1.0)
    var stringColor = NSColor(red: 211/255, green: 35/255, blue: 46/255, alpha: 1.0)
    var identifierColor = NSColor(red: 20/255, green: 156/255, blue: 146/255, alpha: 1.0)
    var keywordColor = NSColor(red: 215/255, green: 0, blue: 143/255, alpha: 1.0)
    var preprocessorColor = NSColor.orange
    
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
            "backgroundColor": self.backgroundColor.hexString,
            "codeColor": self.codeColor.hexString,
            "numberColor": self.numberColor.hexString,
            "stringColor": self.stringColor.hexString,
            "identifierColor": self.identifierColor.hexString,
            "keywordColor": self.keywordColor.hexString,
            "commentColor": self.commentColor.hexString,
            "preprocessorColor": self.preprocessorColor.hexString
        ]
    }
    
    init(from dictionary: Dictionary<String, Any>) {
        
        let dict = dictionary as! Dictionary<String, String>
        self.backgroundColor = NSColor(hexString: dict["backgroundColor"]!)
        self.codeColor = NSColor(hexString: dict["codeColor"]!)
        self.numberColor = NSColor(hexString: dict["numberColor"]!)
        self.stringColor = NSColor(hexString: dict["stringColor"]!)
        self.identifierColor = NSColor(hexString: dict["identifierColor"]!)
        self.keywordColor = NSColor(hexString: dict["keywordColor"]!)
        self.commentColor = NSColor(hexString: dict["commentColor"]!)
        self.preprocessorColor = NSColor(hexString: dict["preprocessorColor"]!)
        
    }
    
}
