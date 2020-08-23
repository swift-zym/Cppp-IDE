//
//  CDCreateProjectViewController.swift
//  C+++
//
//  Created by 23786 on 2020/8/21.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDCreateProjectViewController: NSViewController {
    
    @IBOutlet weak var projectNameTextField: NSTextField!
    @IBOutlet weak var projectVersionTextField: NSTextField!
    @IBOutlet weak var emptyProjectButton: NSButton!
    @IBOutlet weak var customCompileCommandButton: NSButton!
    
    @IBAction func done(_ sender: Any?) {
        
        let panel = NSOpenPanel()
        panel.message = "Choose a directory for your project"
        panel.prompt = "Save"
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        let result = panel.runModal()
        
        guard result == .OK else {
            return
        }
        
        let projectName = self.projectNameTextField.stringValue
        let directory = panel.url!.appendingPathComponent(projectName).path
        
        do {
            
            try FileManager.default.createDirectory(atPath: directory, withIntermediateDirectories: true)
            
            if self.emptyProjectButton.state != .on {
                FileManager.default.createFile(atPath: directory.nsString.appendingPathComponent("main.cpp"), contents: "#include <cstdio>\nint main() {\n\t\n\treturn 0;\n}\n".data(using: .utf8))
                FileManager.default.createFile(atPath: directory.nsString.appendingPathComponent("main.h"), contents: "#ifndef MAIN_H\n#define #MAIN_H\n\n#endif".data(using: .utf8))
            }
            
            if self.customCompileCommandButton.state == .on  {
                FileManager.default.createFile(atPath: directory.nsString.appendingPathComponent("compile.txt"), contents: "# Put your compile command here.".data(using: .utf8))
            }
            
        } catch {
            
            self.showAlert("Error", "Unable to create directory.")
            return
            
        }
        
        let project = CDProject(compileCommand: customCompileCommandButton.state == .on ? "Custom" : "Default", version: self.projectVersionTextField.stringValue)
        
        if self.emptyProjectButton.state != .on {
            project.children.append(.document(.init(path: directory.nsString.appendingPathComponent("main.cpp"))))
            project.children.append(.document(.init(path: directory.nsString.appendingPathComponent("main.h"))))
        }
        
        if self.customCompileCommandButton.state == .on {
            project.children.append(.document(.init(path: directory.nsString.appendingPathComponent("compile.txt"))))
        }
        
        
        do {
            
            let data = try JSONEncoder().encode(project)
            FileManager.default.createFile(atPath: directory.nsString.appendingPathComponent("\(projectName.nsString.appendingPathExtension("cpppproj")!)"), contents: data)
            
        } catch {
            
            self.showAlert("Error", "The data cannot be created.")
            return
            
        }
        
        NSDocumentController.shared.openDocument(withContentsOf: URL(fileURLWithPath: directory.nsString.appendingPathComponent("\(projectName.nsString.appendingPathExtension("cpppproj")!)")), display: true) { (document, bool, error) in
            
            if error != nil {
                self.showAlert("Error", "\(error?.localizedDescription ?? "Unknown Error.")")
            }
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
