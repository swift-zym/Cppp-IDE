//
//  CDDocumentController.swift
//  C+++
//
//  Created by 23786 on 2020/5/31.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa


extension NSDocumentController {
    
    @IBAction func newProject(_ sender: Any?) {
        
        let vc = CDCreateProjectViewController()
        NSApp.mainWindow?.contentViewController?.presentAsSheet(vc)
        
    }
    
    /*
    @IBAction func newGraphicalCodeDocument(_ sender: Any?) {
        
        do {
            (NSDocumentController.shared as! CDDocumentController)._defaultType = "C+++ Graphical Code File"
            try NSDocumentController.shared.openUntitledDocumentAndDisplay(true)
            (NSDocumentController.shared as! CDDocumentController)._defaultType = "C++ Source"
        } catch {
            print("Error")
        }
        
    }*/
    
}



class CDDocumentController: NSDocumentController {
    
    var _defaultType: String = "C++ Source"
    
    override var defaultType: String? {
        return _defaultType
    }
    
    override func openDocument(withContentsOf url: URL, display displayDocument: Bool, completionHandler: @escaping (NSDocument?, Bool, Error?) -> Void) {
        
        super.openDocument(withContentsOf: url, display: displayDocument) {
            (document, success, error) in
            if document is CDCodeDocument {
                guard document != nil || !displayDocument else {
                    GlobalMainWindowController.contentViewController?.showAlert("Error", error?.localizedDescription ?? "")
                    return
                }
                GlobalMainWindowController.addDocument(document! as! CDCodeDocument)
            }
            completionHandler(document, success, error)
        }
        
    }
    
    override func openUntitledDocumentAndDisplay(_ displayDocument: Bool) throws -> NSDocument {
        let doc = try super.openUntitledDocumentAndDisplay(displayDocument)
        if displayDocument {
            GlobalMainWindowController.addDocument(doc as! CDCodeDocument)
        }
        return doc
    }
    
    override func newDocument(_ sender: Any?) {
        super.newDocument(sender)
       /* let panel = NSSavePanel()
        panel.allowedFileTypes = ["cpp", "c", "cxx", "c++", "h", "hpp", "h++", "hxx", "in", "out", "txt", "ans"] //["C++ Source", "C Source", "Input File", "Output File", "C++ Header"]
        panel.message = "Choose a location to save your file."
        let response = panel.runModal()
        if response == .OK {
            if let url = panel.url {
                FileManager.default.createFile(atPath: url.path, contents: """
                    #include <cstdio>
                    int main() {
                        
                        return 0;
                    }
                    """.data(using: .utf8))
                self.openDocument(withContentsOf: url, display: true) {
                    (document, success, error) in
                    if !success || error != nil {
                        NSLog("Something went wrong when creating a file. \(error?.localizedDescription ?? "")")
                    }
                }
            }
        }
        // self.currentDocument?.save(self)
        */
    }
    
}
