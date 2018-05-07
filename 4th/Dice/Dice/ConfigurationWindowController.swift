//
//  ConfigurationWindowController.swift
//  Dice
//
//  Created by Lê Viết Mẫn on 8/15/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

struct DieConfiguration {
    let color: NSColor
    let rolls: Int
    
    init(color: NSColor, rolls: Int) {
        self.color = color
        self.rolls = max(rolls, 1)
    }
}

class ConfigurationWindowController: NSWindowController {

    private dynamic var color: NSColor = NSColor.whiteColor()
    private dynamic var rolls: Int = 10
    
    var configuration: DieConfiguration {
        set {
            color = newValue.color
            rolls = newValue.rolls
        }
        get {
            return DieConfiguration(color: color, rolls: rolls)
        }
    }
    
    override var windowNibName: String {
        return "ConfigurationWindowController"
    }
    
    @IBAction func okayButtonClicked(sender: NSButton) {
        window?.endEditingFor(nil)
        dismissWithModalResponse(NSModalResponseOK)
    }
    
    @IBAction func cancelButtonClicked(sender: NSButton) {
        dismissWithModalResponse(NSModalResponseCancel)
    }
    
    func dismissWithModalResponse(response: NSModalResponse) {
        window!.sheetParent!.endSheet(window!, returnCode: response)
    }
}
