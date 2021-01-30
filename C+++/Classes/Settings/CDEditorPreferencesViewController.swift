//
//  CDEditorPreferencesViewController.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDEditorPreferencesViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var showsCompletionList: NSButton!
    @IBOutlet weak var autoComplete: NSButton!
    @IBOutlet weak var displaysTooltip: NSButton!
    @IBOutlet weak var fontNameLabel: NSTextField!
    @IBOutlet weak var astyleOptions: NSTextField!
    @IBOutlet weak var astyleHelpLabel: NSTextField!
    
    @IBAction func chooseAnotherFont(_ sender: Any?) {
        
        NSFontPanel.shared.setPanelFont(CDSettings.font, isMultiple: false)
        NSFontManager.shared.target = self
        NSFontManager.shared.action = #selector(changeFont(_:))
        NSFontManager.shared.orderFrontFontPanel(self)
        
    }
    
    @objc func changeFont(_ sender: Any?) {
        
        let font = CDSettings.font
        let convertedFont = NSFontPanel.shared.convert(font)
        self.fontNameLabel.stringValue = "Font: " + convertedFont.fontName + " Size: \(Int(convertedFont.pointSize))"
        CDSettings.fontSize = Int(convertedFont.pointSize)
        CDSettings.fontName = convertedFont.fontName
        
    }
    
    @IBAction func showsCompletionListButtonClicked(_ sender: NSButton) {
        CDSettings.codeCompletion = sender.state == .on
    }
    
    @IBAction func autoCompleteButtonClicked(_ sender: NSButton) {
        CDSettings.autoComplete = sender.state == .on
    }
    
    @IBAction func displaysTooltipButtonClicked(_ sender: NSButton) {
        CDSettings.displaysTooltipOfCode = sender.state == .on
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.showsCompletionList.setState(CDSettings.codeCompletion)
        self.autoComplete.setState(CDSettings.autoComplete)
        self.displaysTooltip.setState(CDSettings.displaysTooltipOfCode)
        self.fontNameLabel.stringValue = "Font: " + CDSettings.fontName + " Size: \(Int(CDSettings.fontSize))"
        self.astyleOptions.stringValue = CDSettings.astyleOptions
        
    }
    
    override func viewDidLoad() {
        super.viewDidAppear()
        
        let html = "View <a href=\"http://astyle.sourceforge.net/astyle.html\">Astyle documentation</a> for help."
        let str = NSMutableAttributedString(html: html.data(using: .utf8)!, documentAttributes: nil)!
        str.addAttributes([.font: NSFont.systemFont(ofSize: 13.0), .foregroundColor: NSColor.textColor], range: NSMakeRange(0, str.length))
        self.astyleHelpLabel.attributedStringValue = str
        
    }
    
    func controlTextDidChange(_ obj: Notification) {
        CDSettings.astyleOptions = self.astyleOptions.stringValue
    }
    
}
