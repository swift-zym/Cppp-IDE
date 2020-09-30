//
//  Paragraphs.swift
//  SavannaKit
//
//  Created by Louis D'hauwe on 17/02/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Cocoa

extension TextView {
	
	func paragraphRectForRange(range: NSRange) -> CGRect {
		
		var nsRange = range
		
		let layoutManager: NSLayoutManager
        let textContainer: NSTextContainer
        layoutManager = self.layoutManager!
        textContainer = self.textContainer!
		
		nsRange = layoutManager.glyphRange(forCharacterRange: nsRange, actualCharacterRange: nil)
		
		var sectionRect = layoutManager.boundingRect(forGlyphRange: nsRange, in: textContainer)
		
		// FIXME: don't use this hack
		// This gets triggered for the final paragraph in a textview if the next line is empty (so the last paragraph ends with a newline)
		if sectionRect.origin.x == 0 {
			sectionRect.size.height -= 22
		}
		
		sectionRect.origin.x = 0
		
		return sectionRect
	}
	
}

func generateParagraphs(for textView: SKInnerTextView, flipRects: Bool = false) -> [SKParagraph] {
	
	let range = NSRange(location: 0, length: (textView.text as NSString).length)
	
	var paragraphs = [SKParagraph]()
	var i = 0
	
	(textView.text as NSString).enumerateSubstrings(in: range, options: [.byParagraphs]) { (paragraphContent, paragraphRange, enclosingRange, stop) in
		
		i += 1
		
		let rect = textView.paragraphRectForRange(range: paragraphRange)
		
		let paragraph = SKParagraph(rect: rect, number: i)
		paragraphs.append(paragraph)
		
	}
	
	if textView.text.isEmpty || textView.text.hasSuffix("\n") {
		
		var rect: CGRect
		
        let gutterWidth = textView.textContainerInset.width
		
		let lineHeight: CGFloat = 18
		
		if let last = paragraphs.last {
			
			// FIXME: don't use hardcoded "2" as line spacing
			rect = CGRect(x: 0, y: last.rect.origin.y + last.rect.height + 2, width: gutterWidth, height: last.rect.height)
			
		} else {
			
			rect = CGRect(x: 0, y: 0, width: gutterWidth, height: lineHeight)
			
		}
		
		
		i += 1
		let endParagraph = SKParagraph(rect: rect, number: i)
		paragraphs.append(endParagraph)
		
	}
	
	
	if flipRects {
		
		paragraphs = paragraphs.map { (p) -> SKParagraph in
			
			var p = p
			p.rect.origin.y = textView.bounds.height - p.rect.height - p.rect.origin.y
			
			return p
		}
		
	}
	
	return paragraphs
}

func offsetParagraphs(_ paragraphs: [SKParagraph], for textView: SKInnerTextView, yOffset: CGFloat = 0) -> [SKParagraph] {
	
	var paragraphs = paragraphs
		
    if let yOffset = textView.enclosingScrollView?.contentView.bounds.origin.y {
        
        paragraphs = paragraphs.map { (p) -> SKParagraph in
            
            var p = p
            p.rect.origin.y += yOffset
            
            return p
        }
    }

	
	
	paragraphs = paragraphs.map { (p) -> SKParagraph in
		
		var p = p
		p.rect.origin.y += yOffset
		return p
	}
	
	return paragraphs
}

func drawLineNumbers(_ paragraphs: [SKParagraph], in rect: CGRect, for textView: SKInnerTextView) {
	
	guard let style = textView.theme?.lineNumbersStyle else {
		return
	}
	
	for paragraph in paragraphs {
		
		guard paragraph.rect.intersects(rect) else {
			continue
		}
		
		let attr = paragraph.attributedString(for: style)
		
		var drawRect = paragraph.rect
		
		let gutterWidth = textView.gutterWidth
		
		let drawSize = attr.size()
		
		drawRect.origin.x = gutterWidth - drawSize.width - 4

		drawRect.size.width = drawSize.width
		drawRect.size.height = drawSize.height

		attr.draw(in: drawRect)
		
	}

}
