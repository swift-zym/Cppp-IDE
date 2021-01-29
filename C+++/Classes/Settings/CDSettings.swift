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
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var fontSize: Int {
        get {
            return UserDefaults.standard.integer(forKey: "fontSize")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "fontSize")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var autoComplete: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "autoComplete")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "autoComplete")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var codeCompletion: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "codeCompletion")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "codeCompletion")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var showLiveIssues: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "liveIssues")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "liveIssues")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var checksUpdateAfterLaunching: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "checksUpdate")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "checksUpdate")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var displaysTooltipOfCode: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "codeTooltip")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "codeTooltip")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var compiler: String {
        get {
            return UserDefaults.standard.string(forKey: "compiler") ?? "g++"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "compiler")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var compileArguments: String {
        get {
            return UserDefaults.standard.string(forKey: "compileArguments") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "compileArguments")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var lightTheme: CDCodeEditorTheme {
        get {
            return CDCodeEditorTheme(from: UserDefaults.standard.dictionary(forKey: "lightTheme") ?? [ : ])
        }
        set {
            UserDefaults.standard.setValue(newValue.dictionaryData, forKey: "lightTheme")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var darkTheme: CDCodeEditorTheme {
        get {
            return CDCodeEditorTheme(from: UserDefaults.standard.dictionary(forKey: "darkTheme") ?? [ : ])
        }
        set {
            UserDefaults.standard.setValue(newValue.dictionaryData, forKey: "darkTheme")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    static var astyleOptions: String {
        get {
            return UserDefaults.standard.string(forKey: "astyleOptions") ?? "--style=java --attach-namespaces --attach-classes --attach-inlines --attach-extern-c --attach-closing-while --indent-col1-comments --break-blocks --pad-oper --pad-comma --pad-header --unpad-paren --align-pointer=name --break-one-line-headers --attach-return-type --attach-return-type-decl --convert-tabs --close-templates --max-code-length=110 --break-after-logical"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "astyleOptions")
            NotificationCenter.default.post(name: CDSettings.settingsDidChangeNotificationName, object: nil)
        }
    }
    
    class func setDefault() {
        
        UserDefaults.standard.setValue(true, forKey: "Initialized")
        
        UserDefaults.standard.setValue("Menlo", forKey: "fontName")
        UserDefaults.standard.setValue(15, forKey: "fontSize")
        UserDefaults.standard.setValue(true, forKey: "autoComplete")
        UserDefaults.standard.setValue(true, forKey: "codeCompletion")
        UserDefaults.standard.setValue(true, forKey: "liveIssues")
        UserDefaults.standard.setValue(true, forKey: "checksUpdate")
        UserDefaults.standard.setValue("g++", forKey: "compiler")
        UserDefaults.standard.setValue("", forKey: "compileArguments")
        UserDefaults.standard.setValue("", forKey: "codeTooltip")
        UserDefaults.standard.setValue("--style=java --attach-namespaces --attach-classes --attach-inlines --attach-extern-c --attach-closing-while --indent-col1-comments --break-blocks --pad-oper --pad-comma --pad-header --unpad-paren --align-pointer=name --break-one-line-headers --attach-return-type --attach-return-type-decl --convert-tabs --close-templates --max-code-length=110 --break-after-logical", forKey: "astyleOptions")
        
        UserDefaults.standard.setValue(CDCodeEditorTheme(isDarkMode: false).dictionaryData, forKey: "lightTheme")
        UserDefaults.standard.setValue(CDCodeEditorTheme(isDarkMode: true).dictionaryData, forKey: "darkTheme")
        
    }
    
    static var isInitialized: Bool {
        return UserDefaults.standard.bool(forKey: "Initialized")
    }
    
    static var font: NSFont {
        return NSFont(name: CDSettings.fontName, size: CGFloat(CDSettings.fontSize))!
    }
    
    static func font(ofSize size: CGFloat) -> NSFont {
        return NSFont(name: CDSettings.fontName, size: size)!
    }
    
    static var settingsDidChangeNotificationName = NSNotification.Name("CDSettingsDidChange")
    
}
