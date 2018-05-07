//
//  MainSplitViewController.swift
//  RanchForecastSplit
//
//  Created by Lê Viết Mẫn on 8/16/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController, CourseListViewControllerDelegate
{
    var masterViewController: CourseListViewController {
        let masterItem = splitViewItems[0] as! NSSplitViewItem
        return masterItem.viewController as! CourseListViewController
    }
    
    var detailViewController: WebViewController {
        let masterItem = splitViewItems[1] as! NSSplitViewItem
        return masterItem.viewController as! WebViewController
    }
    
    let defaultURL = NSURL(string: "http://www.bignerdranch.com/")!

    override func viewDidLoad() {
        super.viewDidLoad()
        masterViewController.delegate = self
        //detailViewController.loadURL(defaultURL)
    }
    
    // MARK: CourseListViewControllerDelegate
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) {
        if let course = selectedCourse {
            detailViewController.loadURL(course.url)
        } else {
            detailViewController.loadURL(defaultURL)
        }
    }
    
}
