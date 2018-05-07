//
//  CarArrayController.swift
//  CarLot
//
//  Created by Lê Viết Mẫn on 8/14/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {

    @IBOutlet weak var tableView: NSTableView!
    
    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        newObj.setValue(now, forKey: "datePurchased")
        return newObj
    }
    
    override func addObject(object: AnyObject) {
        super.addObject(object)

        self.rearrangeObjects()

        let sortedCars = self.arrangedObjects as! [Car]

        let row = sortedCars.indexOf(car)!

        tableView.editColumn(0, row: row, withEvent: nil, select: true)
    }
}
