//
//  CDThemePreferencesViewController.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDThemePreferencesViewController: NSViewController {
    
    @IBOutlet weak var lightTheme: CDThemePreferencesView!
    @IBOutlet weak var darkTheme: CDThemePreferencesView!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.lightTheme.setAppearance(isDarkMode: false)
        self.darkTheme.setAppearance(isDarkMode: true)
        
    }
    
}
