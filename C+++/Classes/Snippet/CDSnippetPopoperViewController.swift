//
//  CDSnippetPopoverViewController.swift
//  C+++
//
//  Created by 23786 on 2020/5/7.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

class CDSnippetPopoperViewController: NSViewController, SKSyntaxTextViewDelegate {
    
    
    // MARK: - Properties
        
    let imageNames = ["Code", "YellowCode", "GreenCode", "PurpleCode", "BlueCode"]
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var textView: SKSyntaxTextView!
    @IBOutlet weak var imageView: NSButton!
    @IBOutlet weak var addToCodeButton: NSButton!
    @IBOutlet weak var removeButton: NSButton!
    
    public var imageNameIndex: Int = 0
    private var popover: NSPopover!
    var isEditable: Bool = false
    
    lazy var theme = SKDefaultSourceCodeTheme()
    lazy var lexer = CDCppLexer()
    
    func lexerForSource(_ source: String) -> SKLexer {
        return self.lexer
    }
    /*
    
    @IBAction func addToCode(_ sender: Any) {
        self.delegate_textView.popoverViewController?(self, shouldAddToCode: self.textView.string)
        self.popover?.close()
    }
    
    @objc func removeItem() {
        self.delegate_tableView?.popoverViewController?(self, shouldRemoveItemWithTitle: self.titleLabel.stringValue)
        self.popover?.close()
    }
    */
    @objc func addItem() {
        // self.delegate_tableView?.popoverViewController?(self, shouldAddItemWithTitle: self.titleLabel.stringValue, image: self.imageView.image!, code: self.textView.string)
        self.popover?.close()
    }
    
    @IBAction func changeImage(_ sender: NSButton) {
        
        guard isEditable else {
            return
        }
        
        imageNameIndex += 1
        imageNameIndex %= 5
        self.imageView.image = NSImage(named: imageNames[imageNameIndex])!
        // self.delegate_tableViewCell.popoverViewController?(self, didSetImage: self.imageView.image!)
        
    }

    /** Setup the view controller.
    - parameter title: The title.
    - parameter image: The image.
    - parameter code: The code.
    - parameter mode: Whether it is editable.
    - returns: none
    */
    func setup(title: String, image: NSImage?, code: String, isEditable: Bool) {
        
        self.loadView()
        self.titleLabel.stringValue = title
        self.textView.theme = self.theme
        self.textView.delegate = self
        self.textView.text = code
        self.imageView.image = image
        self.isEditable = isEditable
        
        self.textView.textView.isEditable = isEditable
        self.removeButton.target = self
        // self.removeButton.action = #selector(removeItem)
        
        if self.isEditable == true {
            
            self.titleLabel.isEditable = true
            self.addToCodeButton.isHidden = true
            self.removeButton.action = #selector(addItem)
            self.removeButton.title = "Add"
            
        }
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    func openInPopover(relativeTo rect: NSRect, of view: NSView, preferredEdge edge: NSRectEdge) {
        
        if popover == nil {
            
            popover = NSPopover()
            popover.behavior = .transient
            popover.contentViewController = self
            popover.show(relativeTo: rect, of: view, preferredEdge: edge)
            
        }
        
    }
    
}
