//
//  SKRegexLexer.swift
//  SavannaKit
//
//  Created by Louis D'hauwe on 05/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public typealias SKTokenTransformer = (_ range: Range<String.Index>) -> SKToken

public struct SKRegexTokenGenerator {
	
	public let regularExpression: NSRegularExpression
	
	public let tokenTransformer: SKTokenTransformer
	
	public init(regularExpression: NSRegularExpression, tokenTransformer: @escaping SKTokenTransformer) {
		self.regularExpression = regularExpression
		self.tokenTransformer = tokenTransformer
	}
}

public struct SKKeywordTokenGenerator {
	
	public let keywords: [String]
	
	public let tokenTransformer: SKTokenTransformer
	
	public init(keywords: [String], tokenTransformer: @escaping SKTokenTransformer) {
		self.keywords = keywords
		self.tokenTransformer = tokenTransformer
	}
	
}

public enum TokenGenerator {
	case keywords(SKKeywordTokenGenerator)
	case regex(SKRegexTokenGenerator)
}

public protocol SKRegexLexer: SKLexer {
	
	func generators(source: String) -> [TokenGenerator]
	
}

extension SKRegexLexer {
	
	public func getSavannaTokens(input: String) -> [SKToken] {
		
		let generators = self.generators(source: input)
		
		var tokens = [SKToken]()
		
		for generator in generators {
			
			switch generator {
			case .regex(let regexGenerator):
				tokens.append(contentsOf: generateRegexTokens(regexGenerator, source: input))

			case .keywords(let keywordGenerator):
				tokens.append(contentsOf: generateKeywordTokens(keywordGenerator, source: input))
				
			}
		
		}
	
		return tokens
	}

}

extension SKRegexLexer {

	func generateKeywordTokens(_ generator: SKKeywordTokenGenerator, source: String) -> [SKToken] {

		var tokens = [SKToken]()

		source.enumerateSubstrings(in: source.startIndex..<source.endIndex, options: [.byWords]) { (word, range, _, _) in

			if let word = word, generator.keywords.contains(word) {

				let token = generator.tokenTransformer(range)
				tokens.append(token)

			}

		}

		return tokens
	}
	
	public func generateRegexTokens(_ generator: SKRegexTokenGenerator, source: String) -> [SKToken] {

		var tokens = [SKToken]()

		let fullNSRange = NSRange(location: 0, length: source.utf16.count)
		for numberMatch in generator.regularExpression.matches(in: source, options: [], range: fullNSRange) {
			
			guard let swiftRange = Range(numberMatch.range, in: source) else {
				continue
			}
			
			let token = generator.tokenTransformer(swiftRange)
			tokens.append(token)
			
		}
		
		return tokens
	}

}
