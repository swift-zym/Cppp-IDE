//
//  CDMinimapView.swift
//  C+++
//
//  Created by 23786 on 2020/8/6.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDMinimapView: CDFlippedView {
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var scrollerView: CDMinimapScrollerView!
    @IBOutlet weak var scrollView: NSScrollView!
    
    func didDragScroller() {
        
        let a = self.scrollView.frame.height
        let b = self.scrollView.documentView!.frame.height
        let c = self.imageView.frame.height
        self.scrollerView.frame.size.height = (a / b) * c
        let d = self.scrollerView.frame.origin.y
        self.scrollView.scroll(self.scrollView.contentView, to: NSMakePoint(0, d / c * b))
        self.scrollView.reflectScrolledClipView(self.scrollView.contentView)

    }
    
    func scrollViewDidScrollToPoint(point: NSPoint) {
        
        let a = self.scrollView.frame.height
        let b = self.scrollView.documentView!.frame.height
        let c = self.imageView.frame.height
        let d = point.y
        let res = (a / b) * c
        guard b != 0 && a != 0 && c != 0 && d != 0 else {
            return
        }
        self.scrollerView.frame.size.height = res
        // print("scroller height = scrollview height / textview height * imageviewheight\n                = \(a) / \(b) * \(c)")
        self.scrollerView.frame.origin.y = (d / b) * c
        
    }
    
}
