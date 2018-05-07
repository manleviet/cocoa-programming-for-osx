//
//  Document.swift
//  RaiseMan
//
//  Created by Lê Viết Mẫn on 8/11/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

private var KVOContext: Int = 0

class Document: NSDocument, NSWindowDelegate
{
    var employees: [Employee] = [] {
        willSet {
            for employee in employees {
                stopObservingEmployee(employee)
            }
        }
        didSet {
            for employee in employees {
                startObservingEmployee(employee)
            }
        }
    }
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    
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
        return "Document"
    }

    override func dataOfType(typeName: String) throws -> NSData {
        tableView.window?.endEditingFor(nil)
        return NSKeyedArchiver.archivedDataWithRootObject(employees)
    }

    override func readFromData(data: NSData, ofType typeName: String) throws {
        print("About to read data of type \(typeName).")
        employees = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Employee]
    }

    // MARK - Actions
    
    @IBAction func addEmployee(sender: NSButton) {
        let windowController = windowControllers[0] 
        let window = windowController.window!
        
        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            print("Unable to end editing.")
            return
        }
        
        let undo: NSUndoManager = undoManager!
        
        if undo.groupingLevel > 0 {
            undo.endUndoGrouping()
            undo.beginUndoGrouping()
        }
        
        let employee = arrayController.newObject() as! Employee
        
        arrayController.addObject(employee)
        
        arrayController.rearrangeObjects()
        
        let sortedEmployees = arrayController.arrangedObjects as! [Employee]
        
        let row = sortedEmployees.indexOf(employee)!
        
        print("starting edit of \(employee) in row \(row)")
        tableView.editColumn(0, row: row, withEvent: nil, select: true)
    }
    
    @IBAction func removeEmployees(sender: NSButton) {
        let selectedPeople: [Employee] = arrayController.selectedObjects as! [Employee]
        
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("REMOVE_MESSAGE", comment: "The remove alert's messageText")
        let informativeFormat = NSLocalizedString("REMOVE_INFORMATIVE %d", comment: "The remove alert's informativeText")
        alert.informativeText = String(format: informativeFormat, selectedPeople.count)
        let removeButtonTitle = NSLocalizedString("REMOVE_DO",comment: "The remove alert's remove button")
        alert.addButtonWithTitle(removeButtonTitle)
        let removeCancelTitle = NSLocalizedString("REMOVE_CANCEL", comment: "The remove alert's cancel button")
        alert.addButtonWithTitle(removeCancelTitle)
        
        let window = sender.window!
        alert.beginSheetModalForWindow(window) { response in
            switch (response) {
            case NSAlertFirstButtonReturn:
                self.arrayController.remove(nil)
            default: break
            }
        }
    }
    
    // MARK - Accessors
    func insertObject(employee: Employee, inEmployeesAtIndex index: Int) {
        print("adding \(employee) to the employees array")
        
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(employees.count)
        if !undo.undoing {
            undo.setActionName("Add Person")
        }
        employees.append(employee)
    }
    
    func removeObjectFromEmployeesAtIndex(index: Int) {
        let employee: Employee = employees[index]
        print("removing \(employee) from the employees array")
        
        let undo: NSUndoManager = undoManager!
    
        undo.prepareWithInvocationTarget(self).insertObject(employee, inEmployeesAtIndex: index)
        if !undo.undoing {
            undo.setActionName("Remove Person")
        }
        employees.removeAtIndex(index)
    }
    
    // MARK - Key Value Observing
    func startObservingEmployee(employee: Employee) {
        employee.addObserver(self, forKeyPath: "name", options: .Old, context: &KVOContext)
        employee.addObserver(self, forKeyPath: "raise", options: .Old, context: &KVOContext)
    }
    
    func stopObservingEmployee(employee: Employee) {
        employee.removeObserver(self, forKeyPath: "name")
        employee.removeObserver(self, forKeyPath: "raise")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context != &KVOContext {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        var oldValue: AnyObject? = change[NSKeyValueChangeOldKey]
        if oldValue is NSNull {
            oldValue = nil
        }
        let undo: NSUndoManager = undoManager!
        print("oldValue=\(oldValue)")
        undo.prepareWithInvocationTarget(object).setValue(oldValue, forKeyPath: keyPath)
    }
    
    // MARK - NSWindowDelegate
    func windowWillClose(notification: NSNotification) {
        employees = []
    }
}

