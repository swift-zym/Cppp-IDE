//
//  CDEditorPreferencesViewController.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDEditorPreferencesViewController: NSViewController {
    
    @IBOutlet weak var showsCompletionList: NSButton!
    @IBOutlet weak var autoComplete: NSButton!
    @IBOutlet weak var displaysTooltip: NSButton!
    
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
        
    }
    
}
