//
//  CDFilesTableViewDataSource.swift
//  C+++
//
//  Created by 23786 on 2020/11/1.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDFilesTableViewDataSource: NSObject, CDLeftSidebarTableViewDelegate, NSTableViewDataSource {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 28.0
    }
    
    override init() {
        super.init()
    }
    
    /*private func getAllFilePath(_ dirPath: String) -> [String] {
        var filePaths = [String]()
        do {
            let array = try FileManager.default.contentsOfDirectory(atPath: dirPath)
            for fileName in array {
                var isDir: ObjCBool = true
                let fullPath = "\(dirPath)/\(fileName)"
                if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if !isDir.boolValue {
                        if ["c", "cpp", "cxx", "c++", "h", "hpp", "h++", "hxx", "in", "out", "txt", "md", "markdown", "ans"].contains(fullPath.nsString.pathExtension) {
                            filePaths.append(fullPath)
                        }
                    }
                }
            }
            
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        return filePaths
    }
    */
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
