//
//  CDCodeEditorLineNumberViewButton.swift
//  C+++
//
//  Created by 23786 on 2020/7/31.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCodeEditorLineNumberViewButton: NSButton {
    
    var backgroundColor: NSColor!
    var isBreakpoint: Bool = false
    
    private func drawBackground(color: NSColor) {
        
        self.backgroundColor = color
        self.wantsLayer = true
        self.layer?.backgroundColor = color.cgColor
        self.layer?.setNeedsDisplay()
        
    }
    
    func markAsNoteLine() {
        self.drawBackground(color: .systemGray)
    }
    
    func markAsErrorLine() {
        self.drawBackground(color: .systemRed)
    }
    
    func markAsBreakpointLine() {
        
        let superview = self.superview! as! CDCodeEditorLineNumberView
        if self.isBreakpoint == true {
            self.isBreakpoint = false
            superview.debugLines.remove(self.title.nsString.integerValue)
            GlobalMainWindowController.mainViewController.mainTextView.textView.document?.debugger?.removeBreakpoint(line: self.title.nsString.integerValue)
            superview.draw()
            return
        }
        self.isBreakpoint = true
        self.drawBackground(color: .systemBlue)
        if self.superview != nil {
            superview.debugLines.insert(self.title.nsString.integerValue)
            GlobalMainWindowController.mainViewController.mainTextView.textView.document?.debugger?.addBreakpoint(line: self.title.nsString.integerValue)
        }
        
    }
    
    func markAsWarningLine() {
        self.drawBackground(color: .systemYellow)
    }
    
    func markAsDebugCurrentLine() {
        self.drawBackground(color: .systemGreen)
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.masksToBounds = true
        self.layer?.cornerRadius = frameRect.height / 2 - 4
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
