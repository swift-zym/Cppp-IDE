//
//  SavannaKit+TextViewUtilities.swift
//  C+++
//
//  Created by 23786 on 2020/8/9.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension SKInnerTextView {
    
    @IBAction func biggerFont(_ sender: Any?) {
        
        CDSettings.fontSize += 1
        
    }
    
    @IBAction func smallerFont(_ sender: Any?) {
        
        CDSettings.fontSize -= 1
        
    }
    
    @IBAction func changeSelectionToComment(_ sender: Any?) {
        
        var range = self.selectedRange
        var lineRange = NSMakeRange(0, 0)
        for line in self.string.components(separatedBy: "\n") {
            lineRange.length = line.count + 1
            let anotherRange = NSIntersectionRange(range, lineRange)
            if anotherRange.length != 0 {
                self.string = self.string.nsString.replacingCharacters(in: NSMakeRange(lineRange.location, lineRange.length - 1), with: "//" + line)
                lineRange.location += line.count + 3
                range.length += 2
                continue
            }
            lineRange.location += line.count + 1
        }
        self.setSelectedRange(range)
        
    }
    
    @IBAction func shiftRight(_ sender: Any?) {
        
        var range = self.selectedRange
        var lineRange = NSMakeRange(0, 0)
        for line in self.string.components(separatedBy: "\n") {
            lineRange.length = line.count + 1
            let anotherRange = NSIntersectionRange(range, lineRange)
            if anotherRange.length != 0 {
                self.string = self.string.nsString.replacingCharacters(in: NSMakeRange(lineRange.location, lineRange.length - 1), with: "\t" + line)
                lineRange.location += line.count + 2
                range.length += 1
                continue
            }
            lineRange.location += line.count + 1
        }
        self.setSelectedRange(range)
        
    }
    
    @IBAction func shiftLeft(_ sender: Any?) {
        
        var range = self.selectedRange
        var lineRange = NSMakeRange(0, 0)
        for line in self.string.components(separatedBy: "\n") {
            lineRange.length = line.count + 1
            let anotherRange = NSIntersectionRange(range, lineRange)
            if anotherRange.length != 0 {
                if line.hasPrefix("\t") {
                    self.string = self.string.nsString.replacingCharacters(in: NSMakeRange(lineRange.location, lineRange.length - 1), with: String(line.dropFirst()))
                    lineRange.location += line.count
                    range.length -= 1
                } else {
                    lineRange.location += line.count + 1
                }
                continue
            }
            lineRange.location += line.count + 1
        }
        self.setSelectedRange(range)
        
    }
    
    override func shouldChangeText(in affectedCharRange: NSRange, replacementString: String?) -> Bool {
        /*if replacementString != nil {
            let ans = FormattingHelper.formattedText(for: replacementString!, in: self.string, range: affectedCharRange)
            self.setSelectedRange(ans.newRange)
        }*/
        return super.shouldChangeText(in: affectedCharRange, replacementString: replacementString)
    }
    
}
