//
//  CDTestPointRunView.swift
//  C+++
//
//  Created by 23786 on 2020/12/20.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDTestPointRunView: NSView {
    
    @IBOutlet weak var input: NSTextView?
    @IBOutlet weak var expectedOutput: NSTextView?
    @IBOutlet weak var actualOutput: NSTextView?
    @IBOutlet weak var expectedOutputSwitchButton: NSButton?
    
    @IBAction func expectedOutputButtonClicked(_ sender: Any?) {
        self.expectedOutput?.isHidden = (self.expectedOutputSwitchButton?.state ?? .off) == .off
    }
    
}
