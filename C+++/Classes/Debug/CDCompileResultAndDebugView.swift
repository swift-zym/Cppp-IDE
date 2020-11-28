//
//  CDCompileResultAndConsoleView.swift
//  C+++
//
//  Created by 23786 on 2020/8/1.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa
import SwiftTermMac

class CDCompileResultAndDebugView: NSView {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var errorCountLabel: NSTextField!
    @IBOutlet weak var errorImageLabel: NSImageView!
    @IBOutlet weak var warningCountLabel: NSTextField!
    @IBOutlet weak var warningImageView: NSImageView!
    @IBOutlet weak var commandTextField: NSTextField!
    @IBOutlet weak var debugTextView: NSTextView!
    
    @IBOutlet weak var logView: NSTextView!
    @IBOutlet weak var compileResultTableView: NSTableView!
    
    @IBOutlet weak var debugSplitView: NSSplitView!
    @IBOutlet weak var watchVarsTableView: NSTableView!
    
    var compileResult: CDCompileResult? {
        didSet {
            self.compileResultTableView.dataSource = self.compileResult
            self.errorCountLabel.stringValue = "\(self.compileResult?.errorCount ?? 0)"
            self.warningCountLabel.stringValue = "\(self.compileResult?.warningCount ?? 0)"
        }
    }
    

    private func sendInput(_ string: String) {
        (self.window?.windowController?.document as! CDCodeDocument).sendInputToDebugger(message: string)
    }
    
    @IBAction func run(_ sender: Any?) {
        self.sendInput("run")
    }
    
    @IBAction func next(_ sender: Any?) {
        self.sendInput("next")
    }
    
    @IBAction func `continue`(_ sender: Any?) {
        self.sendInput("continue")
    }
    
    @IBAction func stepIn(_ sender: Any?) {
        self.sendInput("step")
    }
    
    @IBAction func stepOut(_ sender: Any?) {
        self.sendInput("finish")
    }
    
    @IBAction func quit(_ sender: Any?) {
        self.sendInput("quit")
    }
    
    @IBAction func frameVariable(_ sender: Any?) {
        self.sendInput("frame variable")
    }
    
    @IBAction func addWatchVar(_ sender: Any?) {
        CDGetInput(title: "Watch Var Name:", placeholder: "i") { input in
            (self.window?.windowController?.document as! CDCodeDocument).debugger?.addWatchVar(variableName: input)
            self.watchVarsTableView.reloadData()
        }
    }
    
    @IBAction func sendInput(_ sender: Any?) {
        sendInput(self.commandTextField.stringValue)
    }
    
}
