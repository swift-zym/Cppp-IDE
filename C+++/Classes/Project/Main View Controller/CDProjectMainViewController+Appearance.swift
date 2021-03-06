//
//  CDProjectMainViewController+Appearance.swift
//  C+++
//
//  Created by 23786 on 2020/12/9.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDProjectMainViewController {
    
    func convertToLightMode() {
        
        // Change the text view's highlight theme to Light Mode.
        self.currentTheme = CDSettings.lightTheme
        self.codeEditor.theme = self.currentTheme
        
    }
    
    func convertToDarkMode() {
        
        // Change the text view's highlight theme to Dark Mode.
        self.currentTheme = CDSettings.darkTheme
        self.codeEditor.theme = self.currentTheme
        
    }
    
    /// Change the appearance of the current window.
    func changeAppearance(newAppearance: NSAppearance.Name) {
        
        // print("newAppearance.name = \(newAppearance.name)")
        
        if #available(OSX 10.14, *) {
        
            switch newAppearance {
                
                case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua, .accessibilityHighContrastVibrantDark:
                    self.convertToDarkMode()
                    
                case .vibrantLight, .aqua, .accessibilityHighContrastVibrantLight, .accessibilityHighContrastAqua:
                    self.convertToLightMode()
                    
                default:
                    return
                    
            }
            
            // TODO: Switch between dark mode and light mode
        } else {
            
            if self.view.window != nil {
                showAlert("Warning", "Your Mac does not support Dark Mode. Dark Mode requires macOS 10.14 Mojave or later. You should update your Mac.")
            }
            return
            
        }
        
    }
    
}
