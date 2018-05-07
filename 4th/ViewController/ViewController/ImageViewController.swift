//
//  ImageViewController.swift
//  ViewController
//
//  Created by Lê Viết Mẫn on 8/16/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class ImageViewController: NSViewController, ImageRepresentable {
    
    var image: NSImage?
    
    override var nibName: String? {
        return "ImageViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
