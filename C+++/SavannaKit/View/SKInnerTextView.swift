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
	
}
