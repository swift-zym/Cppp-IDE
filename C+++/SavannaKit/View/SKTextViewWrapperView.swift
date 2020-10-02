//
//  TextViewWrapperView.swift
//  SavannaKit
//
//  Created by Louis D'hauwe on 17/02/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Cocoa

class SKTextViewWrapperView: View {
    
    override func hitTest(_ point: NSPoint) -> NSView? {
        // Disable interaction, so we're not blocking the text view.
        return nil
    }
    
    override func layout() {
        super.layout()
        
        self.setNeedsDisplay(self.bounds)
    }
    
    override func resize(withOldSuperviewSize oldSize: NSSize) {
        super.resize(withOldSuperviewSize: oldSize)
        
        self.textView?.invalidateCachedParagraphs()

        self.setNeedsDisplay(self.bounds)
        
    }
    
    var textView: SKInnerTextView?
    
}
