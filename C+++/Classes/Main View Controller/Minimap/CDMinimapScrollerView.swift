//
//  CDMinimapScrollerView.swift
//  C+++
//
//  Created by 23786 on 2020/8/7.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDMinimapScrollerView: NSControl {
    
    var minimapView: CDMinimapView {
        return self.superview! as! CDMinimapView
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        
        let max = min(self.minimapView.imageView.frame.height, self.minimapView.frame.height)
        self.frame.origin.y += event.deltaY
        if self.frame.origin.y <= 0 {
            self.frame.origin.y = 0
        }
        if self.frame.height + self.frame.origin.y >= max {
            self.frame.origin.y = max - self.frame.height
        }
        (self.superview! as! CDMinimapView).didDragScroller()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(white: 0.7, alpha: 0.4).cgColor
        self.setNeedsDisplay()
        
    }
    
}
