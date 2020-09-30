//
//  SKSyntaxTextView.swift
//  SavannaKit
//
//  Created by Louis D'hauwe on 23/01/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation
import CoreGraphics

#if os(macOS)
	import AppKit
#else
	import UIKit
#endif

public protocol SKSyntaxTextViewDelegate: class {
	
	func didChangeText(_ syntaxTextView: SKSyntaxTextView)

	func didChangeSelectedRange(_ syntaxTextView: SKSyntaxTextView, selectedRange: NSRange)
	
	func textViewDidBeginEditing(_ syntaxTextView: SKSyntaxTextView)
	
	func lexerForSource(_ source: String) -> SKLexer
	
}

// Provide default empty implementations of methods that are optional.
public extension SKSyntaxTextViewDelegate {
    func didChangeText(_ syntaxTextView: SKSyntaxTextView) { }
	
    func didChangeSelectedRange(_ syntaxTextView: SKSyntaxTextView, selectedRange: NSRange) { }
	
    func textViewDidBeginEditing(_ syntaxTextView: SKSyntaxTextView) { }
}

struct SKThemeInfo {
	
	let theme: SKSyntaxColorTheme
	
	/// Width of a space character in the theme's font.
	/// Useful for calculating tab indent size.
	let spaceWidth: CGFloat
	
}

@IBDesignable
open class SKSyntaxTextView: View {

	var previousSelectedRange: NSRange?
	
	private var textViewSelectedRangeObserver: NSKeyValueObservation?

	let textView: SKInnerTextView
	
	public var contentTextView: TextView {
		return textView
	}
	
	public weak var delegate: SKSyntaxTextViewDelegate? {
		didSet {
			didUpdateText()
		}
	}
	
	var ignoreSelectionChange = false
	
	#if os(macOS)
	
	let wrapperView = SKTextViewWrapperView()

	#endif
	
	#if os(iOS)

	public var contentInset: UIEdgeInsets = .zero {
		didSet {
			textView.contentInset = contentInset
			textView.scrollIndicatorInsets = contentInset
		}
	}
	
	open override var tintColor: UIColor! {
		didSet {

		}
	}
	
	#else
	
	public var tintColor: NSColor! {
		set {
			textView.tintColor = newValue
		}
		get {
			return textView.tintColor
		}
	}
	
	#endif
    
    public override init(frame: CGRect) {
        textView = SKSyntaxTextView.createInnerTextView()
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        textView = SKSyntaxTextView.createInnerTextView()
        super.init(coder: aDecoder)
        setup()
    }
	
    private static func createInnerTextView() -> SKInnerTextView {
        let textStorage = NSTextStorage()
        let layoutManager = SKSyntaxTextViewLayoutManager()
		#if os(macOS)
        let containerSize = CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude)
		#endif
		
		#if os(iOS)
		let containerSize = CGSize(width: 0, height: 0)
		#endif
		
        let textContainer = NSTextContainer(size: containerSize)
        
        textContainer.widthTracksTextView = true
		
		#if os(iOS)
		textContainer.heightTracksTextView = true
		#endif
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        return SKInnerTextView(frame: .zero, textContainer: textContainer)
    }

	#if os(macOS)

		public let scrollView = NSScrollView()

	#endif
	
	private func setup() {
	
		textView.gutterWidth = 20
		
		#if os(iOS)
			
			textView.translatesAutoresizingMaskIntoConstraints = false
			
		#endif
		
		#if os(macOS)

			wrapperView.translatesAutoresizingMaskIntoConstraints = false
			
			scrollView.backgroundColor = .clear
			scrollView.drawsBackground = false
			
			scrollView.contentView.backgroundColor = .clear
			
			scrollView.translatesAutoresizingMaskIntoConstraints = false

			addSubview(scrollView)
			
			addSubview(wrapperView)

			
			scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
			
			wrapperView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
			wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
			wrapperView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
			wrapperView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
			
			
			scrollView.borderType = .noBorder
			scrollView.hasVerticalScroller = true
			scrollView.hasHorizontalScroller = false
			scrollView.scrollerKnobStyle = .light
			
			scrollView.documentView = textView
			
			scrollView.contentView.postsBoundsChangedNotifications = true
			
			NotificationCenter.default.addObserver(self, selector: #selector(didScroll(_:)), name: NSView.boundsDidChangeNotification, object: scrollView.contentView)
			
			textView.minSize = NSSize(width: 0.0, height: self.bounds.height)
			textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
			textView.isVerticallyResizable = true
			textView.isHorizontallyResizable = false
			textView.autoresizingMask = [.width, .height]
			textView.isEditable = true
			textView.isAutomaticQuoteSubstitutionEnabled = false
			textView.allowsUndo = true
			
			textView.textContainer?.containerSize = NSSize(width: self.bounds.width, height: .greatestFiniteMagnitude)
			textView.textContainer?.widthTracksTextView = true
			
//			textView.layerContentsRedrawPolicy = .beforeViewResize
			
			wrapperView.textView = textView
			
		#else
			
			self.addSubview(textView)
			textView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
			textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
			textView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
			textView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
			self.contentMode = .redraw
			textView.contentMode = .topLeft
		
			textViewSelectedRangeObserver = contentTextView.observe(\UITextView.selectedTextRange) { [weak self] (textView, value) in
			
				if let `self` = self {
					self.delegate?.didChangeSelectedRange(self, selectedRange: self.contentTextView.selectedRange)
				}

			}
			
		#endif
		
		textView.innerDelegate = self
		textView.delegate = self
		
		textView.text = ""

		#if os(iOS)

		textView.autocapitalizationType = .none
		textView.keyboardType = .default
		textView.autocorrectionType = .no
		textView.spellCheckingType = .no
			
		if #available(iOS 11.0, *) {
			textView.smartQuotesType = .no
			textView.smartInsertDeleteType = .no
		}
			
		textView.keyboardAppearance = .dark

		self.clipsToBounds = true
		
		#endif

	}
	
	#if os(macOS)
	
	open override func viewDidMoveToSuperview() {
		super.viewDidMoveToSuperview()
	
	}
	
	@objc func didScroll(_ notification: Notification) {
		
		wrapperView.setNeedsDisplay(wrapperView.bounds)
		
	}

	#endif

	// MARK: -
	
	#if os(iOS)

	override open var isFirstResponder: Bool {
		return textView.isFirstResponder
	}
	
	#endif
	
	@IBInspectable
	public var text: String {
		get {
            return textView.string
		}
        set {
            textView.layer?.isOpaque = true
            textView.string = newValue
            self.didUpdateText()
		}
	}
	
	// MARK: -
	
	public func insertText(_ text: String) {
		
		if shouldChangeText(insertingText: text) {
			
            contentTextView.insertText(text, replacementRange: contentTextView.selectedRange)
			
		}

	}

	public var theme: SKSyntaxColorTheme? {
		didSet {
			
			guard let theme = theme else {
				return
			}
			
			cachedThemeInfo = nil
            textView.backgroundColor = theme.backgroundColor
            textView.theme = theme
			textView.font = theme.font
			
			didUpdateText()
		}
	}
	
	var cachedThemeInfo: SKThemeInfo?
	
	var themeInfo: SKThemeInfo? {
		
		if let cached = cachedThemeInfo {
			return cached
		}
		
		guard let theme = theme else {
			return nil
		}
		
		let spaceAttrString = NSAttributedString(string: " ", attributes: [.font: theme.font])
		let spaceWidth = spaceAttrString.size().width
		
		let info = SKThemeInfo(theme: theme, spaceWidth: spaceWidth)
		
		cachedThemeInfo = info
		
		return info
	}
	
	var cachedTokens: [SKCachedToken]?
	
	func invalidateCachedTokens() {
		cachedTokens = nil
	}
	
	func colorTextView(lexerForSource: (String) -> SKLexer) {
		
		guard let source = textView.text else {
			return
		}
		
		let textStorage: NSTextStorage
		
        textStorage = textView.textStorage!
		
		
//		self.backgroundColor = theme.backgroundColor
		
		let tokens: [SKToken]
		
		if let cachedTokens = cachedTokens {
			
			updateAttributes(textStorage: textStorage, cachedTokens: cachedTokens, source: source)
			
		} else {
			
			guard let theme = self.theme else {
				return
			}
			
			guard let themeInfo = self.themeInfo else {
				return
			}
			
			textView.font = theme.font

			let lexer = lexerForSource(source)
			tokens = lexer.getSavannaTokens(input: source)
			
			let cachedTokens: [SKCachedToken] = tokens.map {
				
				let nsRange = source.nsRange(fromRange: $0.range)
				return SKCachedToken(token: $0, nsRange: nsRange)
			}

			self.cachedTokens = cachedTokens
			
			createAttributes(theme: theme, themeInfo: themeInfo, textStorage: textStorage, cachedTokens: cachedTokens, source: source)
			
		}
		
	}

	func updateAttributes(textStorage: NSTextStorage, cachedTokens: [SKCachedToken], source: String) {

		let selectedRange = textView.selectedRange
		
		let fullRange = NSRange(location: 0, length: (source as NSString).length)
		
		var rangesToUpdate = [(NSRange, SKEditorPlaceholderState)]()
		
		textStorage.enumerateAttribute(.editorPlaceholder, in: fullRange, options: []) { (value, range, stop) in
			
			if let state = value as? SKEditorPlaceholderState {
				
				var newState: SKEditorPlaceholderState = .inactive
				
				if isEditorPlaceholderSelected(selectedRange: selectedRange, tokenRange: range) {
					newState = .active
				}
				
				if newState != state {					
					rangesToUpdate.append((range, newState))
				}
				
			}
		
		}
		
		var didBeginEditing = false
		
		if !rangesToUpdate.isEmpty {
			textStorage.beginEditing()
			didBeginEditing = true
		}
		
		for (range, state) in rangesToUpdate {
			
			var attr = [NSAttributedString.Key: Any]()
			attr[.editorPlaceholder] = state

			textStorage.addAttributes(attr, range: range)

		}
		
		if didBeginEditing {
			textStorage.endEditing()
		}

	}
	
	func createAttributes(theme: SKSyntaxColorTheme, themeInfo: SKThemeInfo, textStorage: NSTextStorage, cachedTokens: [SKCachedToken], source: String) {
		
		textStorage.beginEditing()

		var attributes = [NSAttributedString.Key: Any]()
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.paragraphSpacing = 2.0
		paragraphStyle.defaultTabInterval = themeInfo.spaceWidth * 4
		paragraphStyle.tabStops = []
		
		let wholeRange = NSRange(location: 0, length: (source as NSString).length)
		
		attributes[.paragraphStyle] = paragraphStyle
		
		for (attr, value) in theme.globalAttributes() {
			
			attributes[attr] = value

		}
		
		textStorage.setAttributes(attributes, range: wholeRange)
		
		let selectedRange = textView.selectedRange
		
		for cachedToken in cachedTokens {
			
			let token = cachedToken.token
			
			if token.isPlain {
				continue
			}
			
			let range = cachedToken.nsRange

			if token.isEditorPlaceholder {
				
				let startRange = NSRange(location: range.lowerBound, length: 2)
				let endRange = NSRange(location: range.upperBound - 2, length: 2)
				
				let contentRange = NSRange(location: range.lowerBound + 2, length: range.length - 4)
				
				var attr = [NSAttributedString.Key: Any]()
				
				var state: SKEditorPlaceholderState = .inactive
				
				if isEditorPlaceholderSelected(selectedRange: selectedRange, tokenRange: range) {
					state = .active
				}
				
				attr[.editorPlaceholder] = state
				
				textStorage.addAttributes(theme.attributes(for: token), range: contentRange)
				
				textStorage.addAttributes([.foregroundColor: Color.clear, .font: Font.systemFont(ofSize: 0.01)], range: startRange)
				textStorage.addAttributes([.foregroundColor: Color.clear, .font: Font.systemFont(ofSize: 0.01)], range: endRange)
				
				textStorage.addAttributes(attr, range: range)
				continue
			}
			
			textStorage.addAttributes(theme.attributes(for: token), range: range)
		}
		
		textStorage.endEditing()
		
	}
	
}
