//
//  SKInnerTextView.swift
//  SavannaKit
//
//  Created by Louis D'hauwe on 09/07/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Cocoa

protocol SKInnerTextViewDelegate: class {
	func didUpdateCursorFloatingState()
    var currentTheme: CDCodeEditorTheme { get }
}

class SKInnerTextView: TextView {
    
    var document: CDCodeDocument?
	
	weak var innerDelegate: SKInnerTextViewDelegate?
	
	var theme: SKSyntaxColorTheme?
	
	var cachedParagraphs: [SKParagraph]?
    
    // Code Completion
    var cachedCompletionResults = [CDCompletionResult]()
    var charRangeForCompletion: NSRange?
    var codeCompletionViewController: CDCodeCompletionViewController?
    var wantsCodeCompletion = false
	
	func invalidateCachedParagraphs() {
		cachedParagraphs = nil
	}
	
    
    override func drawBackground(in rect: NSRect) {
        super.drawBackground(in: rect)
        
        guard self.selectedRange.length == 0 else {
            return
        }
        
        let paraRange = self.string.nsString.paragraphRange(for: self.selectedRange)
        let paraGlyphRange = self.layoutManager?.glyphRange(forCharacterRange: paraRange, actualCharacterRange: nil)
        guard paraGlyphRange != nil && self.textContainer != nil else {
            return
        }
        var paraRect = self.layoutManager?.boundingRect(forGlyphRange: paraGlyphRange!,
                                                        in: self.textContainer!)
        guard paraRect != nil else {
            return
        }
        
        paraRect?.size.width = self.frame.width
        self.innerDelegate?.currentTheme.currentLineColor.setFill()
        paraRect?.fill()
        self.needsDisplay = true
        
    }
    
}
