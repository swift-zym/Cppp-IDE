//
//  CDDebugger+NSTableView.swift
//  C+++
//
//  Created by 23786 on 2020/10/8.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDDebugger: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.watchVars.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return self.watchVars[row].name + " = " + (self.watchVars[row].value ?? "Not Found")
    }
    
}

