//
//  SyntaxTextViewLayoutManager.swift
//  SavannaKit iOS
//
//  Created by Louis D'hauwe on 09/03/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Cocoa

public enum SKEditorPlaceholderState {
	case active
	case inactive
}

public extension NSAttributedString.Key {
	
    static let editorPlaceholder = NSAttributedString.Key("editorPlaceholder")
    
    static let foldedCode = NSAttributedString.Key("foldedCode")

}

class SKSyntaxTextViewLayoutManager: NSLayoutManager {
	
	override func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {

        guard let context = NSGraphicsContext.current else {
            return
        }
		
		let range = characterRange(forGlyphRange: glyphsToShow, actualGlyphRange: nil)
		
		var placeholders = [(CGRect, SKEditorPlaceholderState)]()
        var foldedRanges = [(CGFloat, CGFloat)]()
		
		textStorage?.enumerateAttribute(.editorPlaceholder, in: range, options: [], using: { (value, range, stop) in
			
			if let state = value as? SKEditorPlaceholderState {
				
				// the color set above
				let glyphRange = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
				let container = self.textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil)
				
				let rect = self.boundingRect(forGlyphRange: glyphRange, in: container ?? NSTextContainer())
				
				placeholders.append((rect, state))
				
			}
			
		})
        
        textStorage?.enumerateAttribute(.foldedCode, in: range, options: [], using: {
            (value, range, stop) in
            
            if value is Bool {
                
                let range = NSMakeRange(range.lowerBound, 1)
            
                // the color set above
                let glyphRange = self.glyphRange(forCharacterRange: range, actualCharacterRange: nil)
                let container = self.textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil)
                
                let rect = self.boundingRect(forGlyphRange: glyphRange, in: container ?? NSTextContainer())
                
                foldedRanges.append( (rect.origin.x, rect.origin.y) )
                
            }
            
        })

        context.saveGraphicsState()
        context.cgContext.translateBy(x: origin.x, y: origin.y)
		
		for (rect, state) in placeholders {
			
			// UIBezierPath with rounded
			
			let color: Color
			
			switch state {
			case .active:
				color = Color.textColor.withAlphaComponent(0.8)
			case .inactive:
				color = .darkGray
			}

			color.setFill()
			
			let radius: CGFloat = 4.0

            let path = BezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
			
			path.fill()
			
		}
        
        for (x, y) in foldedRanges {
            
            print(x, y)

            NSColor.darkGray.setFill()
            
            let radius: CGFloat = 4.0

            let path = BezierPath(roundedRect: NSMakeRect(x, y, CDSettings.font.pointSize * 3, CDSettings.font.pointSize), xRadius: radius, yRadius: radius)
            
            path.fill()
            
        }

        context.restoreGraphicsState()

		super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)

	}
	
}
