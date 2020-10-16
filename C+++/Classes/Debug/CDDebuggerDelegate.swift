//
//  CDDebuggerDelegate.swift
//  C+++
//
//  Created by 23786 on 2020/10/7.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

protocol CDDebuggerDelegate {
    
    func compileFailed()
    func received(text: String, from: CDDebugger)
    func watchVarRefreshed(varIndex: Int, newValue: String)
    func currentLineMoved(to: Int)
    
}
