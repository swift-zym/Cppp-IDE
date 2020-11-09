//
//  NSButton Extension.swift
//  C+++
//
//  Created by 23786 on 2020/11/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension NSButton {
    
    func setState(_ state: Bool) {
        self.state = state ? .on : .off
    }
    
}
