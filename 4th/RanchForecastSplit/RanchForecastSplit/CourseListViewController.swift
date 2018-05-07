//
//  CourseListViewController.swift
//  RanchForecastSplit
//
//  Created by Lê Viết Mẫn on 8/16/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa

protocol CourseListViewControllerDelegate: class {
    func courseListViewController(viewController: CourseListViewController, selectedCourse: Course?) -> Void
}

class CourseListViewController: NSViewController
{
    dynamic var courses: [Course] = []
    let fetcher = ScheduleFetcher()
    
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    
    weak var delegate: CourseListViewControllerDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchCoursesUsingCompletionHandler { result in
            switch result {
            case .Success(let courses):
                self.courses = courses
                //self.tableView.selectRowIndexes(NSIndexSet(index: 0), byExtendingSelection: false)
                //self.selectCourse(self)
            case .Failure(let error):
                NSAlert(error: error).runModal()
                self.courses = []
            }
        }
    }
    
    @IBAction func selectCourse(sender: AnyObject) {
        let selectedCourse = arrayController.selectedObjects.first as! Course?
        delegate?.courseListViewController(self, selectedCourse: selectedCourse)
    }
    
}
