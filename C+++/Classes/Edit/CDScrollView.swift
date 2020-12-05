//
//  CDScrollView.swift
//  C+++
//
//  Created by apple on 2020/4/21.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

@objc protocol CDScrollViewDelegate {
    @objc optional func scrollView(_: CDScrollView, didScrollTo: NSPoint)
}

class CDScrollView: NSScrollView {
    
    var scrollDelegate: CDScrollViewDelegate?
    
    override func scroll(_ clipView: NSClipView, to point: NSPoint) {
        super.scroll(clipView, to: point)
        
        self.scrollDelegate?.scrollView?(self, didScrollTo: point)
        
    }
    
    func scrollWithoutInformingDelegate(_ clipView: NSClipView, to point: NSPoint) {
        super.scroll(clipView, to: point)
        
    }
    
}
