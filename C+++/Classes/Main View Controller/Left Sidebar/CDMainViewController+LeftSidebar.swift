//
//  CDMainViewController+LeftSidebar.swift
//  C+++
//
//  Created by 23786 on 2020/9/23.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDMainViewController {
    
    @IBAction func changeSidebar(_ sender: NSButton) {
        
        let menu = NSMenu(title: "Menu")
        let a = menu.addItem(withTitle: "Open Files", action: #selector(showOpenFiles), keyEquivalent: "")
        let b = menu.addItem(withTitle: "Snippets", action: #selector(showSnippets), keyEquivalent: "")
        let c = menu.addItem(withTitle: "Diagnostics", action: #selector(showDiagnostics), keyEquivalent: "")
        let d = menu.addItem(withTitle: "Recent Files", action: #selector(showRecentFiles), keyEquivalent: "")
        
        switch self.leftSidebarMode {
            
            case .openFiles:
                a.state = .on
            
            case .snippets:
                b.state = .on
                
            case .diagnostics:
                c.state = .on
                
            case .recentFiles:
                d.state = .on
            
        }
        
        menu.popUp(positioning: nil, at: sender.bounds.origin, in: sender)
        
    }
    
    @objc func showOpenFiles() {
        switchSidebarContentTo(mode: .openFiles)
    }
    
    @objc func showSnippets() {
        switchSidebarContentTo(mode: .snippets)
    }
    
    @objc func showDiagnostics() {
        switchSidebarContentTo(mode: .diagnostics)
    }
    
    @objc func showRecentFiles() {
        switchSidebarContentTo(mode: .recentFiles)
    }
    
    func switchSidebarContentTo(mode: LeftSidebarMode) {
        
        switch mode {
            
            case .snippets:
                self.sidebarTitleLabel.stringValue = "Snippets"
                self.leftSidebarMode = .snippets
                self.leftSidebarTableView.delegate = self.snippetDataSource
                self.leftSidebarTableView.dataSource = self.snippetDataSource
                self.leftSidebarSwitchButton.image = #imageLiteral(resourceName: "Snippet")
            
            case .diagnostics:
                self.sidebarTitleLabel.stringValue = "Diagnostics"
                self.leftSidebarMode = .diagnostics
                self.diagnosticsDataSource.getDiagnostics()
                self.leftSidebarTableView.delegate = self.diagnosticsDataSource
                self.leftSidebarTableView.dataSource = self.diagnosticsDataSource
                self.leftSidebarSwitchButton.image = #imageLiteral(resourceName: "Diagnostics")
                
            case .recentFiles:
                self.sidebarTitleLabel.stringValue = "Recent"
                self.leftSidebarMode = .recentFiles
                self.leftSidebarTableView.delegate = self.recentFilesDataSource
                self.leftSidebarTableView.dataSource = self.recentFilesDataSource
                self.leftSidebarSwitchButton.image = #imageLiteral(resourceName: "Recent")
                
            case .openFiles:
                self.sidebarTitleLabel.stringValue = "Files"
                self.leftSidebarMode = .openFiles
                self.leftSidebarTableView.delegate = self.filesDataSource
                self.leftSidebarTableView.dataSource = self.filesDataSource
                self.leftSidebarSwitchButton.image = #imageLiteral(resourceName: "Folder")
            
        }
        
        self.leftSidebarTableView.menu = (self.leftSidebarTableView.dataSource as? CDLeftSidebarTableViewDelegate)?.menu
        
    }
    
}
