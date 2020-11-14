//
//  NSMenuItem Extension.swift
//  C+++
//
//  Created by 23786 on 2020/11/14.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension NSMenuItem {
    
    convenience init(target: AnyObject?, title: String, action: Selector?, keyEquivalent: String = "") {
        self.init(title: title, action: action, keyEquivalent: keyEquivalent)
        self.target = target
    }
    
}
