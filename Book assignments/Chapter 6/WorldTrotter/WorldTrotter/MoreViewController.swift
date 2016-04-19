//
//  moreViewController.swift
//  WorldTrotter
//
//  Created by Patrick Moraitis on 4/19/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

//why u no import Foundayschunz ?

import UIKit
import WebKit

//Bronze

class MoreViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func loadView() {
        
        webView = WKWebView()
        
        view = webView
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let bnrURL = NSURL(string: "https://www.google.com")
        let reqObj = NSURLRequest(URL: bnrURL!)
        webView.loadRequest(reqObj)
    }
    
}


