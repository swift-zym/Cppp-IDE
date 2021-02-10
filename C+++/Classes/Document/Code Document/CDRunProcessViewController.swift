//
//  CDRunProcessViewController.swift
//  C+++
//
//  Created by 23786 on 2020/11/12.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa
import SwiftTermMac

class CDRunProcessViewController: NSViewController, LocalProcessTerminalViewDelegate {
    
    var command: String = ""
    var time: Date?
    
    @IBOutlet weak var terminalView: LocalProcessTerminalView!
    
    class func run(command: String, name: String) {
        
        let vc = CDRunProcessViewController()
        vc.command = command
        let window = NSWindow(contentViewController: vc)
        window.tabbingMode = .disallowed
        window.title = name
        let wc = NSWindowController(window: window)
        wc.showWindow(nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.terminalView.startProcess(args: ["-c", self.command])
        self.time = Date()
        self.terminalView.nativeForegroundColor = .textColor
        self.terminalView.nativeBackgroundColor = .textBackgroundColor
        self.terminalView.processDelegate = self
        self.terminalView.font = CDSettings.font
        
    }
    
    func processTerminated(source: TerminalView, exitCode: Int32?) {
        let timeInterval = abs(time?.timeIntervalSinceNow ?? 0.00)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.terminalView.feed(text: "\n---------------\nProgram exited with exit code \(exitCode ?? -1)\nTime: \(timeInterval) seconds")
        }
    }
    
    func sizeChanged(source: LocalProcessTerminalView, newCols: Int, newRows: Int) {  }
    
    func setTerminalTitle(source: LocalProcessTerminalView, title: String) {  }
    
    
}
