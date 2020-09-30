//
//  CDRecentFilesTableViewDataSource.swift
//  C+++
//
//  Created by 23786 on 2020/9/24.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDRecentFilesTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    override init() {
        super.init()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return NSDocumentController.shared.recentDocumentURLs.count
    }
    
    func recentFiles() -> [URL] {
        return NSDocumentController.shared.recentDocumentURLs
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("File"), owner: self) as? NSTableCellView {
            view.imageView?.image = CDSnippetTableViewDataSource.savedSnippets[row].image
            view.textField?.stringValue = CDSnippetTableViewDataSource.savedSnippets[row].title
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
