//
//  CDLaunchViewController.swift
//  C+++
//
//  Created by 23786 on 2020/5/24.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDLaunchViewController: NSViewController {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return NSDocumentController.shared.recentDocumentURLs.count
    }
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var recentFilesTableView: NSTableView!
    
    lazy var recentFilesDataSource = CDRecentFilesTableViewDataSource()
    
    @IBAction func tableViewClicked(_ sender: Any?) {
        
        NSWorkspace.shared.open(NSDocumentController.shared.recentDocumentURLs[self.recentFilesTableView.selectedRow])
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        self.recentFilesTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalLaunchViewController = self
        
    }
    
    override func awakeFromNib() {
        self.recentFilesTableView.delegate = self.recentFilesDataSource
        self.recentFilesTableView.dataSource = self.recentFilesDataSource
    }
    
}
