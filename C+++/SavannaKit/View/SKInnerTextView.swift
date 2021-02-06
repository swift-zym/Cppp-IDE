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
        
        let selectedRange = self.selectedRange
        
        guard selectedRange.length == 0 else {
            return
        }
        
        let paraRange = self.string.nsString.paragraphRange(for: selectedRange)
        let paraGlyphRange = self.layoutManager?.glyphRange(forCharacterRange: paraRange, actualCharacterRange: nil)
        
        guard paraGlyphRange != nil && self.textContainer != nil else {
            return
        }
        var paraRect = self.paragraphRect(inGlyphRange: paraGlyphRange!)
        
        if (hasExtraLine && self.string.count == selectedRange.location) {
            paraRect = self.layoutManager?.extraLineFragmentRect ?? NSMakeRect(0, 0, 0, 0)
        }
        
        paraRect.size.width = self.frame.width
        self.innerDelegate?.currentTheme.currentLineColor.setFill()
        paraRect.fill()
        self.needsDisplay = true
        
    }
    
    var hasExtraLine: Bool {
        let str = self.string
        let length = str.count
        if length == 0 {
            return true
        }
        let range = str.nsString.rangeOfComposedCharacterSequence(at: length - 1) // Unicode Line Separator (LSEP)
        let end = str.nsString.substring(with: range)
        let result = end.trimmingCharacters(in: .newlines)
        return result.count == 0
    }
    
    func paragraphRect(inGlyphRange paragraphGlyphRange: NSRange) -> NSRect {
        
        let layoutManager = self.layoutManager
        let containerOrigin = textContainerOrigin
        var lineGlyphRange = NSRange(location: 0, length: 0)
        var paragraphRect = NSRect.zero
        
        // Iterate through the paragraph glyph range, line by line.
        lineGlyphRange = NSRange(location: paragraphGlyphRange.location, length: 0)
        while NSMaxRange(lineGlyphRange) < NSMaxRange(paragraphGlyphRange) {
            // For each line, find the used rect and glyph range, and add the used rect to the paragraph rect.
            let lineUsedRect = layoutManager?.lineFragmentUsedRect(forGlyphAt: lineGlyphRange.location, effectiveRange: &lineGlyphRange)
            paragraphRect = NSUnionRect(paragraphRect, lineUsedRect ?? NSRect.zero)
            lineGlyphRange = NSRange(location: NSMaxRange(lineGlyphRange), length: 0)
        }

        paragraphRect.size.width = self.bounds.size.width
        
        // Convert back from container to view coordinates, then draw the bubble.
        paragraphRect.origin.x += containerOrigin.x
        paragraphRect.origin.y += containerOrigin.y
        
        return paragraphRect
        
    }
    
}
