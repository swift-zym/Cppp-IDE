//
//  CDProjectSidebarViewController.swift
//  C+++
//
//  Created by 23786 on 2020/8/10.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDProjectMainViewController: NSViewController, SKSyntaxTextViewDelegate {
    
    @IBOutlet weak var outlineView: NSOutlineView!
    @IBOutlet weak var fileView: NSView!
    @IBOutlet weak var projectSettingsView: CDProjectSettingsView!
    @IBOutlet weak var codeEditor: SKSyntaxTextView!
    @IBOutlet weak var minimapView: CDMinimapView!
    
    weak var document: CDProjectDocument!
    lazy var cppLexer = CDCppLexer()
    lazy var currentTheme = CDSettings.lightTheme
    var observation: NSKeyValueObservation?
    
    // MARK: - Dragging
    var draggedItem: Any? = nil
    
    // MARK: - Right-Click Menu
    @objc dynamic var isShowInFinderItemEnabled: Bool {
        if let item = self.outlineView?.item(atRow: self.outlineView.clickedRow) as? CDProjectItem {
            switch item {
                case .folder(_): return false
                default: return true
            }
        }
        return false
    }
    
    @objc dynamic var isRemoveFromProjectItemEnabled: Bool {
        if let item = self.outlineView?.item(atRow: self.outlineView.clickedRow) as? CDProjectItem {
            switch item {
                case .project(_): return false
                default: return true
            }
        }
        return false
    }
    
    // MARK: - Document Information
    
    @IBOutlet weak var documentInfoFileNameLabel: NSTextField!
    @IBOutlet weak var documentInfoFileTypeLabel: NSTextField!
    @IBOutlet weak var documentInfoFilePathLabel: NSTextField!
    @IBOutlet weak var documentInfoDescription: NSTextView!
    @IBOutlet weak var log: NSTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.codeEditor.delegate = self
        self.minimapView.codeEditor = self.codeEditor
        
        self.changeAppearance(newAppearance: self.view.effectiveAppearance.name)
       
        // observe the appearance of the view.
        self.observation = observe(\.view.effectiveAppearance, options: [.old, .new]) { object, change in
            
            // print ("old \(change.oldValue!.name) now \(change.newValue!.name).")
            if change.oldValue!.name != change.newValue!.name {
                self.changeAppearance(newAppearance: change.newValue!.name)
            }
            
        }
        
        
        self.outlineView?.registerForDraggedTypes([.string, .fileURL])
        
        self.projectSettingsView?.delegate = self
        
        self.log.font = menloFont(ofSize: 13.0)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        self.document = self.view.window?.windowController?.document as? CDProjectDocument
        self.outlineView.reloadData()
        
        self.projectSettingsView.versionTextField.stringValue = self.document?.project?.version ?? "nil"
        self.projectSettingsView.button.state = self.document?.project?.compileCommand == "Default" ? .on : .off
        
    }
    
    func lexerForSource(_ source: String) -> SKLexer {
        return self.cppLexer
    }
    
    func didScroll(_ syntaxTextView: SKSyntaxTextView, to point: NSPoint) {
        self.minimapView?.scrollViewDidScrollToPoint(syntaxTextView, point: point)
    }
    
    func didChangeText(_ syntaxTextView: SKSyntaxTextView) {
        
        let dataOfView = self.codeEditor.textView.dataWithPDF(inside: self.codeEditor.textView.bounds)
        let imageOfView = NSImage(data: dataOfView)!
        self.minimapView.setMinimapImage(imageOfView)
        
    }
 
    
}
