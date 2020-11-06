//
//  CDLaunchViewController.swift
//  C+++
//
//  Created by 23786 on 2020/5/24.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDLaunchViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        switch tableColumn?.title {
            case "":
                return NSWorkspace.shared.icon(forFile: NSDocumentController.shared.recentDocumentURLs[row].path)
                
            case "File":
                return NSDocumentController.shared.recentDocumentURLs[row].lastPathComponent
                
            default: return nil
        }
    }
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        print(NSDocumentController.shared.recentDocumentURLs.count)
        return NSDocumentController.shared.recentDocumentURLs.count
    }
    
    @IBOutlet weak var titleLabel: NSTextField!
    
    @IBOutlet weak var newFileView: NSView!
    @IBOutlet weak var openFileView: NSView!
    @IBOutlet weak var newProjectView: NSView!
    @IBOutlet weak var recentFilesTableView: NSTableView!
    
    lazy var recentFilesDataSource = CDRecentFilesTableViewDataSource()
    
    @IBAction func tableViewClicked(_ sender: Any?) {
        
        NSWorkspace.shared.open(NSDocumentController.shared.recentDocumentURLs[self.recentFilesTableView.selectedRow])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GlobalLaunchViewController = self
        
    }
    
    override func awakeFromNib() {
        self.recentFilesTableView.delegate = self.recentFilesDataSource
        self.recentFilesTableView.dataSource = self.recentFilesDataSource
    }
    
    @IBAction func showSettingsView(_ sender: Any?) {
        
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
            if let viewController =
                storyboard.instantiateController(
                     withIdentifier: NSStoryboard.SceneIdentifier("CDSettingsViewController")) as? CDSettingsViewController {
                self.presentAsSheet(viewController)
        }
        
    }
    
}
