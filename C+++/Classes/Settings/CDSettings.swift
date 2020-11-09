//
//  Settings.swift
//  C+++
//
//  Created by apple on 2020/4/16.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa
import NotificationCenter

class CDSettings: NSObject {
    
    static var fontName: String {
        get {
            return UserDefaults.standard.string(forKey: "fontName") ?? "Menlo"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "fontName")
        }
    }
    
    static var fontSize: Int {
        get {
            return UserDefaults.standard.integer(forKey: "fontSize")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "fontSize")
        }
    }
    
    static var autoComplete: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "autoComplete")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "autoComplete")
        }
    }
    
    static var codeCompletion: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "codeCompletion")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "codeCompletion")
        }
    }
    
    static var showLiveIssues: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "liveIssues")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "liveIssues")
        }
    }
    
    static var checksUpdateAfterLaunching: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "checksUpdate")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "checksUpdate")
        }
    }
    
    static var displaysTooltipOfCode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "codeTooltip")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "codeTooltip")
        }
    }
    
    static var compiler: String {
        get {
            return UserDefaults.standard.string(forKey: "compiler") ?? "g++"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "compiler")
        }
    }
    
    static var compileArguments: String {
        get {
            return UserDefaults.standard.string(forKey: "compileArguments") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "compileArguments")
        }
    }
    
    static var lightTheme: CDCodeEditorTheme {
        get {
            return CDCodeEditorTheme(from: UserDefaults.standard.dictionary(forKey: "lightTheme") ?? [ : ])
        }
        set {
            UserDefaults.standard.setValue(newValue.dictionaryData, forKey: "lightTheme")
        }
    }
    
    static var darkTheme: CDCodeEditorTheme {
        get {
            return CDCodeEditorTheme(from: UserDefaults.standard.dictionary(forKey: "darkTheme") ?? [ : ])
        }
        set {
            UserDefaults.standard.setValue(newValue.dictionaryData, forKey: "darkTheme")
        }
    }
    
    class func setDefault() {
        
        UserDefaults.standard.setValue("Menlo", forKey: "fontName")
        UserDefaults.standard.setValue(15, forKey: "fontSize")
        UserDefaults.standard.setValue(true, forKey: "autoComplete")
        UserDefaults.standard.setValue(true, forKey: "codeCompletion")
        UserDefaults.standard.setValue(true, forKey: "liveIssues")
        UserDefaults.standard.setValue(true, forKey: "checksUpdate")
        UserDefaults.standard.setValue("g++", forKey: "compiler")
        UserDefaults.standard.setValue("", forKey: "compileArguments")
        UserDefaults.standard.setValue("", forKey: "codeTooltip")
        print(CDCodeEditorTheme().dictionaryData)
        UserDefaults.standard.setValue(CDCodeEditorTheme().dictionaryData, forKey: "lightTheme")
        UserDefaults.standard.setValue(CDCodeEditorTheme().dictionaryData, forKey: "darkTheme")
        
    }
    
    static var isInitialized: Bool {
        return UserDefaults.standard.string(forKey: "fontName") != nil
    }
    
    static var font: NSFont {
        return NSFont(name: CDSettings.fontName, size: CGFloat(CDSettings.fontSize))!
    }
    
    static func font(ofSize size: CGFloat) -> NSFont {
        return NSFont(name: CDSettings.fontName, size: size)!
    }
    
}
