//
//  CDSnippetTableViewDataSource.swift
//  C+++
//
//  Created by 23786 on 2020/9/20.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

protocol CDLeftSidebarTableViewDelegate: NSTableViewDelegate {
    func didClick(tableView: NSTableView)
}

class CDSnippetTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 41.0
    }
    
    override init() {
        super.init()
    }
    
    private static let archievePath = FileManager().urls(for: .libraryDirectory, in: .userDomainMask).first!.appendingPathComponent("C+++").appendingPathComponent("Snippets")
    
    static var savedSnippets: [CDSnippetTableViewCell] {
        return NSKeyedUnarchiver.unarchiveObject(withFile: archievePath.path) as! [CDSnippetTableViewCell]
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        tableView.delegate = self
        return CDSnippetTableViewDataSource.savedSnippets.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Snippet"), owner: self) as? NSTableCellView {
            view.imageView?.image = CDSnippetTableViewDataSource.savedSnippets[row].image
            view.textField?.stringValue = CDSnippetTableViewDataSource.savedSnippets[row].title
            view.rowSizeStyle = .custom
            return view
        }
        return nil
    }
    
    func didClick(tableView: NSTableView) {
        
        let vc = CDSnippetPopoperViewController()
        let current = CDSnippetTableViewDataSource.savedSnippets[tableView.clickedRow]
        vc.setup(title: current.title, image: current.titleLabel.image, code: current.code, isEditable: false)
        vc.openInPopover(relativeTo: tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: true)!.bounds, of: tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: true)!, preferredEdge: .maxX)
        
    }
    
}
