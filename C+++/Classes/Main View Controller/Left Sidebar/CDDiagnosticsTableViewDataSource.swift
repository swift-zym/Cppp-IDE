//
//  CDDiagnosticsTableViewDataSource.swift
//  C+++
//
//  Created by 23786 on 2020/11/13.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDDiagnosticsTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    var diagnostics = [CKDiagnostic]()
    
    var menu: NSMenu? {
        return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25.0
    }
    
    func getDiagnostics() {
        if let diagnostics = GlobalMainWindowController.mainViewController.mainTextView.textView.translationUnit.diagnostics as? [CKDiagnostic] {
            self.diagnostics = diagnostics
        } else {
            self.diagnostics = []
        }
    }
    
    override init() {
        super.init()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return GlobalMainWindowController.mainViewController.mainTextView.textView.translationUnit.diagnostics.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Diagnostics"), owner: self) as? NSTableCellView {
            let diagnostic = self.diagnostics[row]
            switch diagnostic.severity {
                case CKDiagnosticSeverityNote: view.imageView?.image = #imageLiteral(resourceName: "note")
                case CKDiagnosticSeverityWarning: view.imageView?.image = #imageLiteral(resourceName: "warning")
                case CKDiagnosticSeverityError, CKDiagnosticSeverityFatal: view.imageView?.image = #imageLiteral(resourceName: "error")
                default: view.imageView?.image = #imageLiteral(resourceName: "Help")
            }
            view.textField?.stringValue = diagnostic.spelling
            view.rowSizeStyle = .custom
            return view
        }
        return nil
    }
    
    func didClick(tableView: NSTableView) {
        
        
        
    }
    
}
