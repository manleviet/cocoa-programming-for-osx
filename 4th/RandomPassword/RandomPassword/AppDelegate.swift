//
//  AppDelegate.swift
//  RandomPassword
//
//  Created by Lê Viết Mẫn on 8/7/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{

    var mainWindowController: MainWindowsController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
//        let mainWindowController = MainWindowsController(windowNibName: "MainWindowsController")
        let mainWindowController = MainWindowsController()
        mainWindowController.showWindow(self)
        self.mainWindowController = mainWindowController
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

