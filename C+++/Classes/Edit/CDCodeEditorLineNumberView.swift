//
//  CDCodeEditorLineNumberView.swift
//  C+++
//
//  Created by 23786 on 2020/7/30.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCodeEditorLineNumberView: CDFlippedView {
    
    init(frame frameRect: NSRect, textView: NSTextView) {
        super.init(frame: frameRect)
        self.textView = textView
    }
    
    var textView: NSTextView!
    private(set) var buttonsArray = [CDCodeEditorLineNumberViewButton]()
    var debugLines: Set<Int> = []
    var debugCurrentLine: Int?
    var shouldReloadAfterChangingFrame: Bool = true
    
    func markLineAsCurrentDebuggingLine(line: Int) {
        self.debugCurrentLine = line
        self.buttonsArray[line].markAsDebugCurrentLine()
    }
    
    private var textViewLineRects: [NSRect] {
        
        var array = [CGRect]()
        var location = 0
        for line in self.textView.string.components(separatedBy: "\n") {
            let rect = self.textView.layoutManager!.boundingRect(forGlyphRange: NSMakeRange(location, 0), in: self.textView.textContainer!)
            if rect != NSMakeRect(0, 0, 0, 0) {
                array.append(rect)
            }
            location += line.count + 1
        }
        return array
        
    }
    
    override var frame: NSRect {
        didSet {
            DispatchQueue.main.async {
                if self.shouldReloadAfterChangingFrame && oldValue.size != self.frame.size {
                    self.draw()
                }
            }
        }
    }
    
    func draw() {
        
        var lineNumber = 0
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.buttonsArray = [CDCodeEditorLineNumberViewButton]()
        
        let rects = self.textViewLineRects
        for item in rects {
            
            let button = CDCodeEditorLineNumberViewButton(frame: NSMakeRect(2.0, item.origin.y, 34.0, item.height))
            button.isBordered = false
            button.font = NSFont(name: CDSettings.fontName, size: CGFloat(CDSettings.fontSize) * 0.92)
            button.target = self
            button.action = #selector(buttonClicked(_:))
            lineNumber += 1
            button.title = "\(lineNumber)"
            button.sizeToFit()
            button.frame.origin.x = self.bounds.width - button.frame.size.width - 2.0
            self.addSubview(button)
            if self.debugLines.contains(lineNumber) {
                button.markAsBreakpointLine()
            }
            if self.debugCurrentLine ?? -1 == lineNumber {
                button.markAsDebugCurrentLine()
            }
            self.buttonsArray.append(button)
            
        }
        
        self.shouldReloadAfterChangingFrame = false
        self.frame.size.height = (rects.last?.origin.y ?? 0) + (rects.last?.height ?? 0)
        self.superview?.frame.size.height = (rects.last?.origin.y ?? 0) + (rects.last?.height ?? 0)
        self.shouldReloadAfterChangingFrame = true
        
    }
    
    @objc func buttonClicked(_ sender: CDCodeEditorLineNumberViewButton) {
        sender.markAsBreakpointLine()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
