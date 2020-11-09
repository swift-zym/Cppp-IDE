//
//  AppDelegate.swift
//  C+++
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

// MARK: - Global Variables

var GlobalLaunchViewController: CDLaunchViewController!
var GlobalMainWindowController: CDMainWindowController!

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let documentController = CDDocumentController()
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        
        GlobalMainWindowController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "Document Window Controller") as? CDMainWindowController
        
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if !CDSettings.isInitialized {
            CDSettings.setDefault()
        }
        if CDSettings.checksUpdateAfterLaunching {
            NSApplication.shared.checkUpdate(alsoShowAlertWhenUpToDate: false)
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        return .terminateNow
    }
    
    /*
    func applicationShouldOpenUntitledFile(_ sender: NSApplication) -> Bool {
        return false
    }
    */
    
}
