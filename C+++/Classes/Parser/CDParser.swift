//
//  main.swift
//  CommentRemover
//
//  Created by 23786 on 2020/11/24.
//

import Foundation

class CDParser {

    
    private enum ParseMode {
        case stringLiteral
        case commentMayBegin
        case singleLineComment
        case multilineComment
        case multilineCommentMayEnd
        case backslash
        case other
    }

    /*
    struct CodeFoldingLocation: CustomStringConvertible {
        
        init(index: Int = 0, line: Int = 0) {
            self.index = index
            self.line = line
        }
        
        var index = 0, line = 0
        
        var description: String {
            return "Line \(line)"
        }
        
    }*/

    /*
    struct CodeFoldingRange: CustomStringConvertible {
        
        init(begin: CDParser.CodeFoldingLocation, end: CDParser.CodeFoldingLocation) {
            self.begin = begin
            self.end = end
        }
        
        var begin: CodeFoldingLocation
        var end: CodeFoldingLocation
        
        var description: String {
            return "(\(self.begin), \(self.end))"
        }
        
    }*/

    class func removeCommentAndStringLiteral(preserveStringLiteral: Bool = true, from code: String) -> String {

        var newCode = ""
        let lines = code.components(separatedBy: "\n")

        var currentParseMode: ParseMode = .other

        for line in lines {
            
            let array = Array(line)
            for char in array {
                var shouldInsert = true
                switch char {
                    case "\"":
                        if currentParseMode == .backslash {
                            currentParseMode = .stringLiteral
                            shouldInsert = preserveStringLiteral
                        } else if currentParseMode == .other {
                            currentParseMode = .stringLiteral
                        } else if currentParseMode == .stringLiteral {
                            currentParseMode = .other
                            shouldInsert = preserveStringLiteral
                        }
                    case "/":
                        if currentParseMode == .other {
                            currentParseMode = .commentMayBegin
                        } else if currentParseMode == .commentMayBegin {
                            currentParseMode = .singleLineComment
                            shouldInsert = false
                            newCode.removeLast()
                        } else if currentParseMode == .multilineCommentMayEnd {
                            currentParseMode = .other
                            shouldInsert = false
                        } else if currentParseMode == .stringLiteral {
                            shouldInsert = preserveStringLiteral
                        } else if currentParseMode != .other {
                            shouldInsert = false
                        }
                    case "*":
                        if currentParseMode == .commentMayBegin {
                            currentParseMode = .multilineComment
                            shouldInsert = false
                            newCode.removeLast()
                        } else if currentParseMode == .multilineComment {
                            currentParseMode = .multilineCommentMayEnd
                            shouldInsert = false
                        } else if currentParseMode == .stringLiteral {
                            shouldInsert = preserveStringLiteral
                        } else if currentParseMode != .other {
                            shouldInsert = false
                        }
                    case "\\":
                        if currentParseMode == .stringLiteral {
                            currentParseMode = .backslash
                            shouldInsert = preserveStringLiteral
                        }
                        
                    default:
                        if currentParseMode == .singleLineComment || currentParseMode == .multilineComment {
                            shouldInsert = false
                        }
                        if currentParseMode == .stringLiteral || currentParseMode == .backslash {
                            shouldInsert = preserveStringLiteral
                        }
                }
                if shouldInsert {
                    newCode.append(char)
                }
            }
            
            newCode.append("\n")
            
            if currentParseMode == .singleLineComment || currentParseMode == .stringLiteral {
                currentParseMode = .other
            }
            
        }

        return newCode

    }

    /*
    class func getFoldingRanges(from code_: String) -> (ranges: [CodeFoldingRange], lines: [Int]) {

        var ranges = [CodeFoldingRange]()
        var queue = [CodeFoldingLocation]()
        var lineNumbers = [Int]()

        let lines = code_.components(separatedBy: "\n")

        var currentParseMode: ParseMode = .other

        var lineNumber = 1, index = 0

        for line in lines {
            
            let array = Array(line)
            for char in array {
                switch char {
                    case "\"":
                        if currentParseMode == .backslash {
                            currentParseMode = .stringLiteral
                        } else if currentParseMode == .other {
                            currentParseMode = .stringLiteral
                        } else if currentParseMode == .stringLiteral {
                            currentParseMode = .other
                        }
                    case "/":
                        if currentParseMode == .other {
                            currentParseMode = .commentMayBegin
                        } else if currentParseMode == .commentMayBegin {
                            currentParseMode = .singleLineComment
                        } else if currentParseMode == .multilineCommentMayEnd {
                            currentParseMode = .other
                        }
                    case "*":
                        if currentParseMode == .commentMayBegin {
                            currentParseMode = .multilineComment
                        } else if currentParseMode == .multilineComment {
                            currentParseMode = .multilineCommentMayEnd
                        }
                    case "\\":
                        if currentParseMode == .stringLiteral {
                            currentParseMode = .backslash
                        }
                    default:
                        if currentParseMode == .stringLiteral || currentParseMode == .singleLineComment || currentParseMode == .multilineComment || currentParseMode == .backslash {
                        }
                }
                
                if currentParseMode == .other {
                    if char == "{" {
                        queue.append(CodeFoldingLocation(index: index, line: lineNumber))
                    } else if char == "}" {
                        if queue.count >= 1 {
                            ranges.append(CodeFoldingRange(begin: queue.last!, end: CodeFoldingLocation(index: index, line: lineNumber)))
                            lineNumbers.append(queue.last!.line)
                            queue.removeLast()
                        }
                    }
                }
                index += 1
            }
            
            if currentParseMode == .singleLineComment || currentParseMode == .stringLiteral {
                currentParseMode = .other
            }
            
            lineNumber += 1
            index += 1
            
        }

        return (ranges: ranges, lines: lineNumbers)
        
    }
    */
    
}
