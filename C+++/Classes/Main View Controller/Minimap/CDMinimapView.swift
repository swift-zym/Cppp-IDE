//
//  CDMinimapView.swift
//  C+++
//
//  Created by 23786 on 2020/8/6.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDMinimapView: NSControl {
    
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var scrollerView: CDMinimapScrollerView!
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var visibleAreaHeight: CGFloat {
        return self.frame.height
    }
    
    var minimapVisibleAreaHeight: CGFloat {
        return min(self.frame.height, self.imageView.frame.height)
    }
    
    func setMinimapImage(_ image: NSImage) {
        
        self.imageView.image = image
        
        if self.imageView.frame.width != 0 && image.size.width != 0 {
            self.imageView.superview?.frame.size.height = image.size.height / (image.size.width / self.imageView.frame.width)
            self.heightConstraint.constant = image.size.height / (image.size.width / self.imageView.frame.width)
        }
        
        
    }
    /*
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        self.scrollerView.isHidden = false
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        self.scrollerView.isHidden = true
    }
    */
    func didDragScroller() {
        
        
        
    }
    
    func scrollViewDidScrollToPoint(_ view: SKSyntaxTextView, point: NSPoint) {
        
        let totalHeight = view.textView.frame.height
        
        let ratio = self.imageView.frame.height / totalHeight
        
        let scrollerViewHeight = visibleAreaHeight * ratio
        self.scrollerView.frame.size.height = scrollerViewHeight
        
        let scrollerY: CGFloat
        
        if minimapVisibleAreaHeight == visibleAreaHeight {
            scrollerY = (point.y / (totalHeight - visibleAreaHeight) * totalHeight) / view.textView.frame.height * (minimapVisibleAreaHeight - scrollerViewHeight)
            
            let imageViewY = point.y * ratio - scrollerY
            self.scrollView.scroll(self.scrollView.contentView, to: NSMakePoint(0.0, imageViewY))
            self.scrollView.reflectScrolledClipView(self.scrollView.contentView)
            
        } else {
            scrollerY = point.y / view.textView.frame.height * minimapVisibleAreaHeight
        }
        
        self.scrollerView.frame.origin.y = visibleAreaHeight - (scrollerY + scrollerViewHeight)
        
    }
    
    override func updateTrackingAreas() {
        
        for area in self.trackingAreas {
            self.removeTrackingArea(area)
        }
        
        let trackingArea = NSTrackingArea(rect: self.bounds, options: [.activeAlways, .mouseEnteredAndExited], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
}
