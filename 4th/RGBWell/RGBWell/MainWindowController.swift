//
//  MainWindowController.swift
//  RGBWell
//
//  Created by Lê Viết Mẫn on 8/9/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController
{
    var r = 0.0
    var g = 0.0
    var b = 0.0
    var a = 1.0
    
    @IBOutlet weak var colorWell: NSColorWell!
    
    @IBOutlet weak var redSlider: NSSlider!
    @IBOutlet weak var greenSlider: NSSlider!
    @IBOutlet weak var blueSlider: NSSlider!
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        redSlider.doubleValue = r
        greenSlider.doubleValue = g
        blueSlider.doubleValue = b
        updateColor()
    }
    
    enum IdentifierSlider : String {
        case RedSlider = "Red Slider"
        case GreenSlider = "Green Slider"
        case BlueSlider = "Blue Slider"
    }
    
    @IBAction func adjustRed(sender: NSSlider) {
        if let identifier = sender.identifier {
            switch identifier {
            case IdentifierSlider.RedSlider.rawValue:
                println("R slider's value is \(sender.doubleValue)")
                r = sender.doubleValue
            case IdentifierSlider.GreenSlider.rawValue:
                println("G slider's value is \(sender.doubleValue)")
                g = sender.doubleValue
            case IdentifierSlider.BlueSlider.rawValue:
                println("B slider's value is \(sender.doubleValue)")
                b = sender.doubleValue
            default: break
            }
            updateColor()
        }
    }
    
    func updateColor() {
        let color = NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        colorWell.color = color
    }
}