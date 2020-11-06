//
//  CDFilesTableViewDataSource.swift
//  C+++
//
//  Created by 23786 on 2020/11/1.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDFilesTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    var menu: NSMenu? {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Close", action: #selector(CDMainWindowController.closeSelectedDocument), keyEquivalent: ""))
        return menu
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25.0
    }
    
    override init() {
        super.init()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return GlobalMainWindowController.documents.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("File"), owner: self) as? NSTableCellView {
            let doc = GlobalMainWindowController.documents[row]
            if doc.fileURL != nil {
                view.imageView?.image = NSWorkspace.shared.icon(forFile: doc.fileURL!.path)
            }
            view.textField?.stringValue = doc.fileURL?.lastPathComponent ?? "Untitled"
            view.rowSizeStyle = .custom
            return view
        }
        return nil
    }
    
    func didClick(tableView: NSTableView) {
        
        GlobalMainWindowController.setCurrentDocument(index: tableView.clickedRow)
        
    }
    
}
