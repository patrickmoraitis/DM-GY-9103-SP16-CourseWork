//
//  webViewController.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 5/3/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

//This class and overall implementation of web view in this project is based on the following tutorial - http://www.alphansotech.com/blogs/how-to-use-web-view-in-ios-using-swift/

class WebViewController: UIViewController {

    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let url = NSURL (string: "http://nylottery.ny.gov")

        let requestObj = NSURLRequest(URL: url!)
        
        webView.scalesPageToFit = true
        
        webView.loadRequest(requestObj)
        
        //adjust inset - https://forums.xamarin.com/discussion/9791/set-a-top-margin-for-a-webview-in-ios
        webView.scrollView.contentInset = UIEdgeInsets(top: -60,left: 0,bottom: -60,right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("WARNING - MEMORY")
    }
    
    @IBAction func backAction(sender: AnyObject) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @IBAction func forwardAction(sender: AnyObject) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(sender: AnyObject) {
        webView.reload()
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        webView.stopLoading()
    }
    
}