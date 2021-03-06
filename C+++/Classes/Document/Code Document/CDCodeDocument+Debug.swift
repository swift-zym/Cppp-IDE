//
//  CDCodeDocument+Debug.swift
//  C+++
//
//  Created by 23786 on 2020/8/1.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDCodeDocument: CDDebuggerDelegate {
    
    func compileFailed() {
        self.contentViewController.showAlert("Compile Failed", "Please check your code and try again.")
    }
    
    func received(text: String, from: CDDebugger) {
        let debugTextView = self.contentViewController.consoleView.debugTextView
        guard debugTextView != nil else {
            return
        }
        debugTextView?.string += text
        debugTextView?.scrollRangeToVisible(NSMakeRange(debugTextView!.string.count - 2, 1))
    }
    
    func watchVarRefreshed(varIndex: Int, newValue: String) {
        self.contentViewController.consoleView.watchVarsTableView.reloadData()
    }
    
    func currentLineMoved(to line: Int) {
        self.contentViewController.mainTextView.lineNumberView?.markLineAsCurrentDebuggingLine(line: line - 1)
    }
    
    
    func beginDebugging() {
        
        if self.fileURL == nil {
            self.contentViewController?.showAlert("Error", "You haven't saved your file yet. You must save your file before debugging it.")
            return
        }
        
        self.debugger = CDDebugger(filePath: self.fileURL!.path)
        self.debugger?.delegate = self
        self.contentViewController.consoleView.watchVarsTableView.dataSource = self.debugger
        
        for i in self.contentViewController.mainTextView.lineNumberView?.debugLines ?? [] {
            self.debugger?.addBreakpoint(line: i)
        }
        
        self.debugger?.begin()
        
    }
    
    func sendInputToDebugger(message: String) {
        self.debugger?.sendCommand(command: message)
    }
    
    @IBAction func beginDebugging(_ sender: Any?) {
        self.beginDebugging()
    }
    
    func endDebugging() {
        self.debugTask?.terminate()
        self.contentViewController.setStatus(string: "\(self.fileURL?.lastPathComponent ?? "C+++") | Finished Debugging")
    }
    
}
