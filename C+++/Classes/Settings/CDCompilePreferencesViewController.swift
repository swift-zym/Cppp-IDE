//
//  CDCompilePreferencesViewController.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCompilePreferencesViewController: NSViewController, NSTextFieldDelegate, NSComboBoxDelegate {
    
    @IBOutlet weak var compiler: NSComboBox!
    @IBOutlet weak var arguments: NSTextField!
    
    @IBOutlet weak var timeLimit: NSPopUpButton!
    @IBOutlet weak var runArguments: NSTextField!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.compiler.stringValue = CDSettings.compiler
        self.arguments.stringValue = CDSettings.compileArguments
        // self.timeLimit.select(self.timeLimit.item(withTitle: String(CDSettings.timeLimit)))
        self.timeLimit.title = String(CDSettings.timeLimit)
        self.runArguments.stringValue = CDSettings.runArguments
        
    }
    
    override func viewDidLoad() {
        super.viewDidAppear()
        
        self.compiler.delegate = self
        self.arguments.delegate = self
        
    }
    
    func controlTextDidChange(_ obj: Notification) {
        CDSettings.compiler = compiler.stringValue
        CDSettings.compileArguments = arguments.stringValue
        CDSettings.runArguments = runArguments.stringValue
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        CDSettings.compiler = compiler.stringValue
    }
    
    @IBAction func didClickPopupButton(_ sender: NSPopUpButton) {
        CDSettings.timeLimit = Double(sender.title) ?? 2.0
    }
    
}
