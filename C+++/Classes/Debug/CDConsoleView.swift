//
//  CDCompileResultAndConsoleView.swift
//  C+++
//
//  Created by 23786 on 2020/8/1.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCompileResultAndConsoleView: NSView, CDConsoleTextViewDelegate {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var errorCountLabel: NSTextField!
    @IBOutlet weak var warningCountLabel: NSTextField!
    var compileResult: CDCompileResult? {
        didSet {
            self.tableView.dataSource = self.compileResult
            self.errorCountLabel.stringValue = "\(self.compileResult?.errorCount ?? 0)"
            self.warningCountLabel.stringValue = "\(self.compileResult?.warningCount ?? 0)"
            self.titleLabel.stringValue = self.compileResult?.succeed ?? false ? "Compile Succeed" : "Compile Failed"
        }
    }
    
    @IBOutlet weak var textView: CDConsoleTextView!
    @IBOutlet weak var tableView: NSTableView!
    
    private func sendInput(_ string: String) {
        (self.window?.windowController?.document as! CDCodeDocument).sendInputToDebugger(message: string)
    }
    
    func consoleTextViewWillInsertNewLine(_ consoleTextView: CDConsoleTextView, lastLineText: String) {
        self.sendInput(lastLineText)
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
    
}
