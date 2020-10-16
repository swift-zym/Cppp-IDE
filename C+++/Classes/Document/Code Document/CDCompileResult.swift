//
//  CDCompileResult.swift
//  C+++
//
//  Created by 23786 on 2020/10/6.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCompileResult: NSObject, NSTableViewDelegate, NSTableViewDataSource {
    
    var errors = [CDCompileError]()
    
    var errorCount = 0
    var warningCount = 0
    
    func calculateErrorAndWarningCount() {
        self.errorCount = 0
        self.warningCount = 0
        for error in self.errors {
            switch error.type {
                case .error:
                    errorCount += 1
                case .warning:
                    warningCount += 1
                default:
                    break
            }
        }
    }
    
    var succeed: Bool {
        return self.errorCount == 0
    }
    
    // Table View Data Source
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.errors.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        switch tableColumn?.title {
            
            case " ": // image
                return self.errors[row].image
                
            case "File":
                return self.errors[row].file
            
            case "Line":
                return String(self.errors[row].line)
                
            case "Col":
                return String(self.errors[row].column)
                
            case "  ": // message
                return self.errors[row].message
                
            default:
                return nil
            
        }
        
    }
    
}
