//
//  Course.swift
//  
//
//  Created by Lê Viết Mẫn on 8/16/15.
//
//

import Foundation

public class Course: NSObject {
    public let title: String
    public let url: NSURL
    public let nextStartDate: NSDate
    
    public init(title: String, url: NSURL, nextStartDate: NSDate) {
        self.title = title
        self.url = url
        self.nextStartDate = nextStartDate
        super.init()
    }
}