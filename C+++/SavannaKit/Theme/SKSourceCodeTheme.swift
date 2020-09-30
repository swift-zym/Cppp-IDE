//
//  SourceCodeTheme.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public protocol SKSourceCodeTheme: SKSyntaxColorTheme {
	
	func color(for syntaxColorType: SKSourceCodeTokenType) -> Color
	
}

extension SKSourceCodeTheme {
	
	public func globalAttributes() -> [NSAttributedString.Key: Any] {
		
		var attributes = [NSAttributedString.Key: Any]()
		
		attributes[.font] = font
        attributes[.foregroundColor] = color(for: .plain)
		
		return attributes
	}
	
	public func attributes(for token: SKToken) -> [NSAttributedString.Key: Any] {
		var attributes = [NSAttributedString.Key: Any]()
		
		if let token = token as? SKSimpleSourceCodeToken {
			attributes[.foregroundColor] = color(for: token.type)
		}
		
		return attributes
	}
	
}
