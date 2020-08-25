//
//  CDProjectMainViewController+Dragging.swift
//  C+++
//
//  Created by 23786 on 2020/8/15.
//  Copyright © 2020 Zhu Yixuan. All rights reserved.
//

import Cocoa

extension CDProjectMainViewController {

    func outlineView(_ outlineView: NSOutlineView, pasteboardWriterForItem item: Any) -> NSPasteboardWriting? {
        self.draggedItem = item
        let item = NSPasteboardItem()
        item.setString("", forType: .string)
        return item
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        return .move
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        
        if item == nil {
            return false
        }
        
        // If the user drags a file from Finder
        if info.draggingPasteboard.types != nil && info.draggingPasteboard.types!.contains(.fileURL) && item as? CDProjectItem != nil {
            
            print("fileURL")
            
            var newIndex   : Int
            var newParent  : Any
            
            switch item as! CDProjectItem {
                
                case .document(_):
                    newParent   =  self.outlineView.parent(forItem: item!)!
                    newIndex    =  self.outlineView.childIndex(forItem: item!)
                    
                default:
                    newParent   =  item!
                    newIndex    =  0
            }
            
            if let data = info.draggingPasteboard.data(forType: .fileURL), let url = URL(dataRepresentation: data, relativeTo: nil) {
                
                self.document.project.children.insert(.document(.init(path: url.path)), at: newIndex)
                self.outlineView.insertItems(at: IndexSet(arrayLiteral: newIndex), inParent: newParent)
                return true
                
            } else {
                
                self.showAlert("Unknown Error", "Cannot add file to project.")
                return false
                
            }
            
        }
        
        // Reordering
        if let projectItem = item as? CDProjectItem, let nonNilDraggedItem = self.draggedItem {
            
            var newIndex   : Int
            var newParent  : Any
            let oldIndex   : Int   =  self.outlineView.childIndex(forItem: nonNilDraggedItem)
            let oldParent  : Any   =  self.outlineView.parent(forItem: nonNilDraggedItem)!
            
            switch projectItem {
                case .document(_):
                    newParent   =  self.outlineView.parent(forItem: item!)!
                    newIndex    =  self.outlineView.childIndex(forItem: item!)
                    
                default:
                    newParent   =  item!
                    newIndex    =  0
            }
            
            self.outlineView.moveItem(at: oldIndex, inParent: oldParent, to: newIndex, inParent: newParent)
            
            if let oldProjectParent = oldParent as? CDProjectItem, let newProjectParent = newParent as? CDProjectItem, let draggedProjectItem = self.draggedItem as? CDProjectItem {
                switch oldProjectParent {
                    case .document(_):
                        break
                    case .project(let project):
                        project.children.remove(at: oldIndex)
                    case .folder(let folder):
                        folder.children.remove(at: oldIndex)
                }
                switch newProjectParent {
                    case .document(_):
                        break
                    case .project(let project):
                        project.children.insert(draggedProjectItem, at: newIndex)
                    case .folder(let folder):
                        folder.children.insert(draggedProjectItem, at: newIndex)
                }
            }
            
        }
        
        return true
        
    }
    
    
    func outlineView(_ outlineView: NSOutlineView, draggingSession session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        self.draggedItem = nil
    }
    
    
}
