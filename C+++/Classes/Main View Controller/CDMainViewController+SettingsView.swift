//
//  CDMainViewController+SettingsView.swift
//  C+++
//
//  Created by 23786 on 2020/7/3.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDMainViewController {
    
    @objc func settingsDidChange(_ notification: NSNotification) {
        
        self.changeAppearance(newAppearance: self.view.effectiveAppearance.name)
        
    }
    
}
