//
//  WebViewController.swift
//  RanchForecastSplit
//
//  Created by Lê Viết Mẫn on 8/16/15.
//  Copyright (c) 2015 Lê Viết Mẫn. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {
    
    var webView: WKWebView {
        return view as! WKWebView
    }
    
    override func loadView() {
        let webView = WKWebView()
        view = webView
    }
    
    func loadURL(url: NSURL) {
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
