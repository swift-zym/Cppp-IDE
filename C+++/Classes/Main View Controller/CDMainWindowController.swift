//
//  WindowController.swift
//  C+++
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDMainWindowController: NSWindowController, NSWindowDelegate {
    
    @objc dynamic var statusString = "C+++ | Ready"
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.shouldCascadeWindows = true
        
    }
    
    func disableCompiling() {
        
        let vc = (self.contentViewController as! CDMainViewController)
        vc.enterSimpleMode(self)
        vc.rightConstraint.constant = 0.0
        
    }
    
    @IBAction func toggleLeftSidebar(_ sender: Any?) {
        
        let vc = (self.contentViewController as! CDMainViewController)
        vc.toggleLeftSidebar(sender)
        
    }
    
}
