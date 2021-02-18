//
//  CDGeneralPreferencesViewController.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Foundation

class CDGeneralPreferencesViewController: NSViewController {
    
    @IBOutlet weak var checkForNewVersionsButton: NSButton!
    @IBOutlet weak var showLiveIssuesButton: NSButton!
    
    
    @IBAction func checkForNewVersionsButtonClicked(_ sender: NSButton) {
        CDSettings.checksUpdateAfterLaunching = sender.state == .on
    }
    
    @IBAction func showLiveIssuesButtonClicked(_ sender: NSButton) {
        CDSettings.showLiveIssues = sender.state == .on
    }
    
    @IBAction func resetSettings(_ sender: Any) {
        CDSettings.setDefault()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.checkForNewVersionsButton.setState(CDSettings.checksUpdateAfterLaunching)
        self.showLiveIssuesButton.setState(CDSettings.showLiveIssues)
        
    }
    
}
