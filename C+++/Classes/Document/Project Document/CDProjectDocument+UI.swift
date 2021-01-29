//
//  CDProjectDocument+UI.swift
//  C+++
//
//  Created by 23786 on 2020/8/11.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//
//  The project function is cancelled because OIers don't need to build projects.

/*

import Cocoa

extension CDProjectDocument {
    
    func openDocument(item: CDProjectItem) {
        
        self.save(nil)
        
        switch item {
            
            case .document(let document):
                
                self.contentViewController?.projectSettingsView?.isHidden = true
                self.contentViewController?.codeEditor?.isHidden = false
                self.contentViewController?.minimapView.isHidden = false
                
                self.contentViewController.documentInfoFileNameLabel.stringValue = document.path.nsString.lastPathComponent
                self.contentViewController.documentInfoFilePathLabel.stringValue = document.path
                var documentType = "Other"
                switch document.path.nsString.pathExtension.lowercased() {
                    case "cpp", "cxx", "c++": documentType = "C++ Source"
                    case "c": documentType = "C Source"
                    case "h", "hpp", "h++": documentType = "Header"
                    case "in": documentType = "Input File"
                    case "out", "ans": documentType = "Output File"
                    default: break
                }
                documentType = "Type: \(documentType)"
                
                self.contentViewController.documentInfoFileTypeLabel.stringValue = documentType
                self.contentViewController.documentInfoDescription.string = document.fileDescription ?? ""
                
                // Try to open the document in a content view controller.
                do {
                    
                    guard !self.contentWindowController.documents.keys.contains(document.path) else {
                        self.contentWindowController.setCurrentDocument(documentURL: document.path)
                        return
                    }
                    let doc = try CDCodeDocument(contentsOf: URL(fileURLWithPath: document.path), ofType: "C++ Source")
                    NSDocumentController.shared.addDocument(doc)
                    self.contentWindowController.addDocument(url: document.path, document: doc)
                    
                } catch {
                    
                    self.contentViewController.showAlert("Error", "Unable to open file. The file may have been moved to another directory or deleted.")
                    
                }
                
            case .project(_):
                
                self.contentViewController?.projectSettingsView?.isHidden = false
                self.contentViewController?.codeEditor?.isHidden = true
                self.contentViewController?.minimapView.isHidden = true
                
                self.contentViewController.documentInfoFileNameLabel.stringValue = self.fileURL?.lastPathComponent ?? "Not saved"
                self.contentViewController.documentInfoFilePathLabel.stringValue = self.fileURL?.path ?? "Not saved"
                self.contentViewController.documentInfoFileTypeLabel.stringValue = "Type: Project"
                self.contentViewController.documentInfoDescription.string = project.fileDescription ?? ""
                
            case .folder(let folder):
                
                self.contentViewController?.projectSettingsView?.isHidden = true
                
                self.contentViewController.documentInfoFileNameLabel.stringValue = folder.name
                self.contentViewController.documentInfoFilePathLabel.stringValue = "-"
                self.contentViewController.documentInfoFileTypeLabel.stringValue = "Type: Folder"
                self.contentViewController.documentInfoDescription.string = folder.fileDescription ?? ""
                
        }
        
    }
    

    
}

*/
