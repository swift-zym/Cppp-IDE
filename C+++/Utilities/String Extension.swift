//
//  String Extension.swift
//  C+++
//
//  Created by 23786 on 2020/7/16.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension String {
    
    subscript (i: Int) -> Character {
        guard i < self.count && i >= 0 else {
            return " "
        }
        return self[ self.index(startIndex, offsetBy: i) ]
    }
    
    func index(_ int: Int) -> Index {
        return self.index(self.startIndex, offsetBy: int)
    }
    
    subscript (bounds: Range<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    var nsString: NSString {
        return NSString(string: self)
    }
    
    func findPositionOf(substring: String, backwards: Bool = false) -> Int {
        var pos = -1
        if let range = range(of:substring, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
    /// Count how many times a character appears in a string.
    /// - Parameter character: The character.
    /// - Returns: How many times the character appears in the string.
    func challenge(_ character: Character) -> Int {
        Array(self).reduce(0, {$1 == character ? $0 + 1 : $0})
    }
    
    /// Get the number of the line which the character at a specific position is in.
    /// - Parameter position: The position.
    /// - Returns: The number of the line which the character at `position` is in.
    func lineNumber(at position: Int) -> Int {
        
        var lineNumber = 0
        var characterPosition = 0
        for line in self.components(separatedBy: "\n") {
            lineNumber += 1
            characterPosition += line.count + 1
            if (position <= characterPosition) {
                return lineNumber;
            }
        }
        return 1
        
    }
    
    func columnNumber(at position: Int) -> Int {
        
        var characterPosition = 0
        for line in self.components(separatedBy: "\n") {
            if characterPosition + line.count + 1 >= position {
                return position - characterPosition
            }
            characterPosition += line.count + 1
        }
        return 1
        
    }
    
    var isIdentifier: Bool {
        get {
            if self.count == 0 {
                return true
            }
            if !(Array(self)[1].isLetter || Array(self)[1] == "_") {
                return false
            }
            for (i, char) in Array(self).enumerated() {
                if i == 0 {
                    continue
                }
                if !(char.isLetter || char.isNumber || char == "_") {
                    return false
                }
            }
            return true
        }
    }
    
    /// Returns the index of the first substring in the string.
    /// - Parameters:
    ///   - string: The substring.
    /// - Returns: The index of the first substring in the string. -1 if not found.
    func firstIndexOf(_ string: String) -> Int {
        
        var pos = -1
        if let range = range(of: string, options: .literal) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
        
    }
    
    func compareWith(anotherString string: String) -> (right: Bool, ranges: [NSRange]) {
        guard string.first == self.first else {
            return (false, [])
        }
        var ranges = [NSRange]()
        var i = 0, j = 0
        let lengthA = string.count
        let lengthB = self.count
        while i < lengthA && j < lengthB {
            if string[i] == self[j] {
                ranges.append(NSMakeRange(j, 1))
                i += 1
            }
            j += 1
        }
        if i != lengthA {
            return (right: false, ranges: [])
        }
        return (right: true, ranges: ranges)
    }
    
    
    func findAllIndex(_ string:String) -> [NSRange] {
        var ranges: [NSRange] = []
        if string.elementsEqual("") {
            return ranges
        }
        let zero = self.startIndex
        let target = Array(string)
        let total = Array(self)
        
        let lenght = string.count
        var startPoint = 0
        
        while total.count >= startPoint + string.count {
            if total[startPoint] == target[0] {
                let startIndex = self.index(zero, offsetBy: startPoint)
                let endIndex = self.index(startIndex, offsetBy: lenght)
                let child = self[startIndex..<endIndex]
                if child.elementsEqual(string) {
                    ranges.append(NSRange(location: startPoint, length: lenght))
                    startPoint += lenght
                } else {
                    startPoint += 1
                }
            } else {
                startPoint += 1
            }
        }
        return ranges
    }

}
