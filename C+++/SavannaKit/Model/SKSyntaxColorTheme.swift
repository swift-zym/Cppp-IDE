//
//  SyntaxTheme.swift
//  SavannaKit
//
//  Created by Louis D'hauwe on 24/01/2017.
//  Copyright © 2017 Silver Fox. All rights reserved.
//

import Foundation
import CoreGraphics

public struct SKLineNumbersStyle {
	
	public let font: Font
	public let textColor: Color
	
	public init(font: Font, textColor: Color) {
		self.font = font
		self.textColor = textColor
	}

}

public struct SKGutterStyle {

	public let backgroundColor: Color

	/// If line numbers are displayed, the gutter width adapts to fit all line numbers.
	/// This specifies the minimum width that the gutter should have at all times,
	/// regardless of any line numbers.
	public let minimumWidth: CGFloat
	
	public init(backgroundColor: Color, minimumWidth: CGFloat) {
		self.backgroundColor = backgroundColor
		self.minimumWidth = minimumWidth
	}
}

public protocol SKSyntaxColorTheme {
	
	/// Nil hides line numbers.
	var lineNumbersStyle: SKLineNumbersStyle? { get }
	
	var gutterStyle: SKGutterStyle { get }
	
	var font: Font { get }
	
	var backgroundColor: Color { get }

	func globalAttributes() -> [NSAttributedString.Key: Any]

	func attributes(for token: SKToken) -> [NSAttributedString.Key: Any]
}
