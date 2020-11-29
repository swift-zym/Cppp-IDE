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
        
        switch self.leftSidebarMode {
            
            case .openFiles:
                switchSidebarContentTo(mode: .snippets)
            
            case .snippets:
                switchSidebarContentTo(mode: .diagnostics)
                
            case .diagnostics:
                switchSidebarContentTo(mode: .recentFiles)
                
            case .recentFiles:
                switchSidebarContentTo(mode: .openFiles)
            
        }
        
        self.leftSidebarTableView.menu = (self.leftSidebarTableView.dataSource as? CDLeftSidebarTableViewDelegate)?.menu
        
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
