//
//  Document.swift
//  CarLot
//
//  Created by Lê Viết Mẫn on 8/14/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

    @IBOutlet var carsArrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }

//    @IBAction func addCar(sender: NSButton) {
//        
//        let windowController = windowControllers[0] as! NSWindowController
//        let window = windowController.window!
//        
//        let endedEditing = window.makeFirstResponder(window)
//        if !endedEditing {
//            println("Unable to end editing.")
//            return
//        }
//        
//        let undo: NSUndoManager = undoManager!
//        
//        if undo.groupingLevel > 0 {
//            undo.endUndoGrouping()
//            undo.beginUndoGrouping()
//        }
//        
//        let car = carsArrayController.newObject() as! Car
//        carsArrayController.addObject(car)
//        
//        carsArrayController.rearrangeObjects()
//        
//        let sortedCars = carsArrayController.arrangedObjects as! [Car]
//        
//        let row = find(sortedCars, car)!
//        
//        println("starting edit of \(car) in row \(row)")
//        tableView.editColumn(0, row: row, withEvent: nil, select: true)
//    }
}
