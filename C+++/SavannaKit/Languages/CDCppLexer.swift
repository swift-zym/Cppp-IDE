//
//  CDCppLexer.swift
//  SourceEditor
//
//  Created by Louis D'hauwe on 24/07/2018.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

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
        generators.append(regexGenerator("\\b[A-Z][a-zA-Z]+\\b", tokenType: .identifier))
        
        // Functions
        
        generators.append(regexGenerator("\\b(println|print)(?=\\()", tokenType: .identifier))
        
        generators.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))
        
        generators.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))
        
        let keywords = "break case int short long auto catch class continue convenience default else enum false asm signed unsigned for func guard if in init inout internal NULL virtual char operator private public new const friend template inline union goto float double void register return this static struct switch throw true try typedef while extern sizeof".components(separatedBy: " ")
        
        generators.append(keywordGenerator(keywords, tokenType: .keyword))
        
        let stdlibIdentifiers = "std string cin cout cerr clog stdin stdout stderr stringstream istringstream ostringstream auto_ptr deque list queue stack vector map set bitset multiset multimap unordered_set unordered_map unordered_multiset unordered_multimap array shared_ptr abort abs acos asin atan2 atan calloc ceil cosh cos exit exp fabs floor fmod fprintf fputs free frexp fscanf isalnum isalpha iscntrl isdigit isgraph islower isprint ispunct isspace isupper isxdigit tolower toupper labs ldexp log10 log malloc realloc memchr memcmp memcpy memset modf pow printf putchar puts scanf sinh sin snprintf sprintf sqrt sscanf strcat strchr strcmp strcpy strcspn strlen strncat strncmp strncpy strpbrk strrchr strspn strstr tanh tan vfprintf vprintf vsprintf endl initializer_list unique_ptr priority_queue freopen pair".components(separatedBy: " ")
        
        generators.append(keywordGenerator(stdlibIdentifiers, tokenType: .identifier))
        
        // Line comment
        generators.append(regexGenerator("//(.*)", tokenType: .comment))
        
        // Block comment
        generators.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        // Single-line string literal
        generators.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))

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
