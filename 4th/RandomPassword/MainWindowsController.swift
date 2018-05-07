//
//  MainWindowsController.swift
//  RandomPassword
//
//  Created by Lê Viết Mẫn on 8/7/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class MainWindowsController: NSWindowController
{

    @IBOutlet weak var textField: NSTextField!
    
    override var windowNibName: String? {
        return "MainWindowsController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func generatePassword(sender: AnyObject) {
        let length = 8
        let password = generateRandomString(length)
        textField.stringValue = password
    }
}
