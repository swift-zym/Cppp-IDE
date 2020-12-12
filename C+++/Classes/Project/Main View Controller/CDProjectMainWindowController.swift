//
//  CDProjectMainWindowController.swift
//  C+++
//
//  Created by 23786 on 2020/12/9.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDProjectMainWindowController: NSWindowController, NSWindowDelegate {
    
    var documents: [String : CDCodeDocument] = [ : ]
    
    var mainViewController: CDProjectMainViewController? {
        return self.contentViewController as? CDProjectMainViewController
    }
    
    func addDocument(url: String, document: CDCodeDocument) {
        
        if !self.documents.keys.contains(url) {
            self.documents[url] = document
        }

        self.setCurrentDocument(documentURL: url)
        
    }
    
    func setCurrentDocument(documentURL: String) {
        
        self.document?.removeWindowController(self)
        let document = self.documents[documentURL]
        guard document != nil else {
            return
        }
        document!.addWindowController(self)
        self.document = document
        self.mainViewController?.codeEditor.setDocument(newDocument: document!)
        
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        self.window?.delegate = self
        
    }
    
    func windowWillClose(_ notification: Notification) {
        
        self.documents.forEach() { doc in
            doc.value.close()
        }
        self.documents = [ : ]
        
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        
        GlobalLaunchViewController.view.window?.close()
        
    }
    
    override func close() {
        super.close()
        
    }
    
    @IBAction func compile(_ sender: Any?) {
        self.mainViewController?.document.compile(sender)
    }
    
    
}
