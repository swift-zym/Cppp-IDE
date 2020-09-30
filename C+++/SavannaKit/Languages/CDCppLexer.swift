//
//  CDCppLexer.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

import Foundation

public enum SKSourceCodeTokenType {
    case plain
    case number
    case string
    case identifier
    case keyword
    case comment
    case editorPlaceholder
}

protocol SKSourceCodeToken: SKToken {
    
    var type: SKSourceCodeTokenType { get }
    
}

extension SKSourceCodeToken {
    
    var isEditorPlaceholder: Bool {
        return type == .editorPlaceholder
    }
    
    var isPlain: Bool {
        return type == .plain
    }
    
}

struct SKSimpleSourceCodeToken: SKSourceCodeToken {
    
    let type: SKSourceCodeTokenType
    
    let range: Range<String.Index>
    
}

extension SKRegexLexer {
    public func regexGenerator(_ pattern: String, options: NSRegularExpression.Options = [], transformer: @escaping SKTokenTransformer) -> TokenGenerator? {
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return nil
        }
        
        return .regex(SKRegexTokenGenerator(regularExpression: regex, tokenTransformer: transformer))
    }

}

class CDCppLexer: SKRegexLexer {
    
    public init() {
        
    }
    
    lazy var generators: [TokenGenerator] = {
        
        var generators = [TokenGenerator?]()
        
        // UI/App Kit
        generators.append(regexGenerator("\\b(NS|UI)[A-Z][a-zA-Z]+\\b", tokenType: .identifier))
        
        // Functions
        
        generators.append(regexGenerator("\\b(println|print)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        let keywords = "as associatedtype break case catch class continue convenience default defer deinit else enum extension fallthrough false fileprivate final for func get guard if import in init inout internal is lazy let mutating nil nonmutating open operator override private protocol public repeat required rethrows return required self set static struct subscript super switch throw throws true try typealias unowned var weak where while".components(separatedBy: " ")
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        let stdlibIdentifiers = "Any Array AutoreleasingUnsafePointer BidirectionalReverseView Bit Bool CFunctionPointer COpaquePointer CVaListPointer Character CollectionOfOne ConstUnsafePointer ContiguousArray Data Dictionary DictionaryGenerator DictionaryIndex Double EmptyCollection EmptyGenerator EnumerateGenerator FilterCollectionView FilterCollectionViewIndex FilterGenerator FilterSequenceView Float Float80 FloatingPointClassification GeneratorOf GeneratorOfOne GeneratorSequence HeapBuffer HeapBuffer HeapBufferStorage HeapBufferStorageBase ImplicitlyUnwrappedOptional IndexingGenerator Int Int16 Int32 Int64 Int8 IntEncoder LazyBidirectionalCollection LazyForwardCollection LazyRandomAccessCollection LazySequence Less MapCollectionView MapSequenceGenerator MapSequenceView MirrorDisposition ObjectIdentifier OnHeap Optional PermutationGenerator QuickLookObject RandomAccessReverseView Range RangeGenerator RawByte Repeat ReverseBidirectionalIndex Printable ReverseRandomAccessIndex SequenceOf SinkOf Slice StaticString StrideThrough StrideThroughGenerator StrideTo StrideToGenerator String Index UTF8View Index UnicodeScalarView IndexType GeneratorType UTF16View UInt UInt16 UInt32 UInt64 UInt8 UTF16 UTF32 UTF8 UnicodeDecodingResult UnicodeScalar Unmanaged UnsafeArray UnsafeArrayGenerator UnsafeMutableArray UnsafePointer VaListBuilder Header Zip2 ZipGenerator2".components(separatedBy: " ")
        
        generators.append(keywordGenerator(stdlibIdentifiers, tokenType: .identifier))
        
        // Line comment
        generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))
        
        // Multi-line string literal
        generators.append(regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        // Editor placeholder
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generators.compactMap( { $0 })
    }()
    
    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }
    
    
    
    public func regexGenerator(_ pattern: String, options: NSRegularExpression.Options = [], tokenType: SKSourceCodeTokenType) -> TokenGenerator? {
        
        return regexGenerator(pattern, options: options, transformer: { (range) -> SKToken in
            return SKSimpleSourceCodeToken(type: tokenType, range: range)
        })
    }
    
    public func keywordGenerator(_ words: [String], tokenType: SKSourceCodeTokenType) -> TokenGenerator {
        
        return .keywords(SKKeywordTokenGenerator(keywords: words, tokenTransformer: { (range) -> SKToken in
            return SKSimpleSourceCodeToken(type: tokenType, range: range)
        }))
    }
    
}
