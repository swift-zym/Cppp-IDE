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
    var menu: NSMenu? { get }
    
}

class CDSnippetTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    var menu: NSMenu? {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(target: self, title: "Remove", action: #selector(CDSnippetTableViewDataSource.remove(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(target: self, title: "Move Up", action: #selector(CDSnippetTableViewDataSource.moveUp(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(target: self, title: "Move Down", action: #selector(CDSnippetTableViewDataSource.moveDown(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(target: self, title: "Add...", action: #selector(CDSnippetTableViewDataSource.showAddSnippetPopover(_:)), keyEquivalent: ""))
        return menu
    }
    
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 35.0
    }
    
    override init() {
        super.init()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return CDSnippetController.shared.snippets.count
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("Snippet"), owner: self) as? NSTableCellView {
            view.imageView?.image = CDSnippetController.shared.snippets[row].image
            view.textField?.stringValue = CDSnippetController.shared.snippets[row].title
            view.rowSizeStyle = .custom
            return view
        }
        return nil
    }
    
    func didClick(tableView: NSTableView) {
        
        guard tableView.clickedRow >= 0 else {
            return
        }
        
        let vc = CDSnippetPopoperViewController()
        let current = CDSnippetController.shared.snippets[tableView.clickedRow]
        vc.setup(title: current.title, image: current.image, code: current.code, completion: current.completion ?? "", isEditable: false, index: tableView.clickedRow)
        vc.openInPopover(relativeTo: tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: true)!.bounds, of: tableView.view(atColumn: 0, row: tableView.clickedRow, makeIfNecessary: true)!, preferredEdge: .maxX)
        
    }
    
    private var clickedIndex: Int {
        return GlobalMainWindowController.mainViewController.leftSidebarTableView.clickedRow
    }
    
    @objc func remove(_ sender: Any?) {
        CDSnippetController.shared.remove(at: clickedIndex)
        GlobalMainWindowController.mainViewController.leftSidebarTableView.reloadData()
    }
    
    @objc func moveUp(_ sender: Any?) {
        CDSnippetController.shared.moveSnippetUp(index: clickedIndex)
        GlobalMainWindowController.mainViewController.leftSidebarTableView.reloadData()
    }
    
    @objc func moveDown(_ sender: Any?) {
        CDSnippetController.shared.moveSnippetDown(index: clickedIndex)
        GlobalMainWindowController.mainViewController.leftSidebarTableView.reloadData()
    }
    
    @objc func showAddSnippetPopover(_ sender: Any?) {
        let vc = CDSnippetPopoperViewController()
        vc.setup(title: "Snippet Title", image: #imageLiteral(resourceName: "Code"), code: "Code\n", completion: "", isEditable: true, index: -1)
        vc.openInPopover(relativeTo: GlobalMainWindowController.mainViewController.leftSidebarTableView.bounds, of: GlobalMainWindowController.mainViewController.leftSidebarTableView, preferredEdge: .maxX)
        
    }
    
}
