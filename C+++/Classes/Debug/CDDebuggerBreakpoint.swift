//
//  CDDebuggerBreakpoint.swift
//  C+++
//
//  Created by 23786 on 2020/10/16.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDDebuggerBreakpoint: NSObject {
    
    var line: Int
    var index: Int
    
    init(line: Int, index: Int) {
        
        self.line = line
        self.index = index
        
    }
    
    override var hash: Int {
        return line
    }
    
}
