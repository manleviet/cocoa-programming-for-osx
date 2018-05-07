//
//  Employee.swift
//  RaiseMan
//
//  Created by Lê Viết Mẫn on 8/11/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Foundation

class Employee: NSObject, NSCoding {
    var name: String? = "New Employee"
    var raise: Float = 0.05
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String?
        raise = aDecoder.decodeFloatForKey("raise")
        super.init()
    }
    
    func validateRaise(raiseNumberPointer: AutoreleasingUnsafeMutablePointer<NSNumber?>) throws {
        let raiseNumber = raiseNumberPointer.memory
        if raiseNumber == nil {
            throw NSError(domain: "UserInputValidationErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "An employee's raise must be a number."])
        } else {
            return
        }
    }
    
    // MARK - NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        if let name = name {
            aCoder.encodeObject(name, forKey: "name")
        }
        aCoder.encodeFloat(raise, forKey: "raise")
    }
}