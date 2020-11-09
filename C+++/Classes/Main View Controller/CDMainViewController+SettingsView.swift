//
//  CDMainViewController+SettingsView.swift
//  C+++
//
//  Created by 23786 on 2020/7/3.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDMainViewController/* : CDSettingsViewDelegate*/ {
    
    @IBAction func showSettingsView(_ sender: Any) {
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        if let viewController =
            storyboard.instantiateController(
                withIdentifier: NSStoryboard.SceneIdentifier("CDSettingsViewController")) as? CDSettingsViewController {
            // ViewController.delegate = self
            self.presentAsSheet(viewController)
        }
        
    }
    
    /*func settingsViewControllerDidSet() {
        
        // Theme
        switch isDarkMode {
            case false:
                self.mainTextView.highlightr?.setTheme(to: CDSettings.darkThemeName)
            case true:
                self.mainTextView.highlightr?.setTheme(to: CDSettings.lightThemeName)
        }
        
        // Font
        self.mainTextView.highlightr?.theme.setCodeFont(CDSettings.font)
        self.mainTextView.font = CDSettings.font
        self.mainTextView.didChangeText()
        
        // In case of errors
        changeAppearance(self)
        changeAppearance(self)
        
    }*/
    
    
    @objc func settingsDidChange(_ notification: NSNotification) {
        
        self.changeAppearance(newAppearance: self.view.effectiveAppearance.name)
        
    }
    
}
