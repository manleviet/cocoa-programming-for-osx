//
//  MainWindowController.swift
//  ToDo
//
//  Created by Lê Viết Mẫn on 8/11/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource, NSTableViewDelegate
{
    var todo : [String] = []

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func createNewItemWithName(sender: AnyObject) {
        todo += [textField.stringValue]
        tableView.reloadData()
    }
    
    // MARK - conform NSTableViewDataSource
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return todo.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let todo = self.todo[row]
        return todo
    }
    
    // MARK - conform NSTableViewDelegate
    func tableView(tableView: NSTableView, shouldEditTableColumn tableColumn: NSTableColumn?, row: Int) -> Bool {
        return true
    }
}
