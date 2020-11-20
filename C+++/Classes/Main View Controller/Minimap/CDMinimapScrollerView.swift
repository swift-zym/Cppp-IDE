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
        
        self.frame.origin.y -= event.deltaY
        if self.frame.origin.y + self.frame.height >= self.minimapView.visibleAreaHeight {
            self.frame.origin.y = self.minimapView.visibleAreaHeight - self.frame.height
        }
        if self.frame.origin.y <= self.minimapView.visibleAreaHeight -  self.minimapView.minimapVisibleAreaHeight {
            self.frame.origin.y = self.minimapView.visibleAreaHeight -  self.minimapView.minimapVisibleAreaHeight
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
