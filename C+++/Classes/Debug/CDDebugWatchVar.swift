//
//  CDDebugWatchVar.swift
//  C+++
//
//  Created by 23786 on 2020/10/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDDebugWatchVar: NSObject {
    
    var name: String
    var index: Int?
    var value: String?
    
    init(name: String, index: Int? = nil) {
        self.name = name
        self.index = index
    }
    
}
