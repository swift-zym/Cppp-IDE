//
//  CDRecentFilesTableViewDataSource.swift
//  C+++
//
//  Created by 23786 on 2020/9/24.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDRecentFilesTableCellView: NSTableCellView {
    
    @IBOutlet weak var pathLabel: NSTextField?
    
}

class CDRecentFilesTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 51.0
    }
    
    override init() {
        super.init()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.recentFiles().count
    }
    
    func recentFiles() -> [URL] {
        return NSDocumentController.shared.recentDocumentURLs
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("File"), owner: self) as? CDRecentFilesTableCellView {
            view.imageView?.image = NSWorkspace.shared.icon(forFile: self.recentFiles()[row].path)
            view.textField?.stringValue = self.recentFiles()[row].lastPathComponent
            view.pathLabel?.stringValue = self.recentFiles()[row].deletingLastPathComponent().path
            view.rowSizeStyle = .custom
            return view
        }
        return nil
    }
    
    func didClick(tableView: NSTableView) {
        
        NSDocumentController.shared.openDocument(withContentsOf: recentFiles()[tableView.clickedRow], display: true, completionHandler: { (_, _, _) in } )
        
        /*let vc = CDSnippetPopoperViewController()
        let current = CDSnippetTableViewDataSource.savedSnippets[tableView.clickedRow]
        vc.setup(title: current.title, image: current.titleLabel.image, code: current.code, isEditable: false)
        vc.openInPopover(relativeTo: tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: true)!.bounds, of: tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: true)!, preferredEdge: .maxX)*/
        
    }
    
}
