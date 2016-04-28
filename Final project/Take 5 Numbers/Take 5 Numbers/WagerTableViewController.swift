//
//  WagerTableViewController.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/24/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class WagerTableViewController: UITableViewController{
    
//MARK : Properties
    
    //var wagers = [Wager]()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem()
    }

    
//BEGIN UICollectionViewDataSource protocol
    
    //Sections - default return is 1
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    //Rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(wagers.count)
        //print(wagerLog.allWagers.count)
        return WagerStore.sharedInstance.allWagers.count
    }
    
    //Cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                
        // Get the cell prototyped in the storyboard
        let cellIdentifier = "wagerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WagerTableViewCell
        
        //print(WagerStore.sharedInstance.allWagers)
        
        // Fetches the appropriate wager for the data source layout
        let wager = WagerStore.sharedInstance.allWagers[indexPath.row]
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        cell.pick5Label.text = wager.pickK.map{ "\($0)"}.joinWithSeparator(", ")
        cell.dateLabel?.text = formatter.stringFromDate(wager.dateK)
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the view and the data archive
            WagerStore.sharedInstance.removeWagerAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            //WagerStore.sharedInstance.allWagers.removeAtIndex(indexPath.row)
        }
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    // MARK: NSCoding
    
    func saveWagers(){
        WagerStore.sharedInstance.save()
    }
    
    func loadWagers() {
        WagerStore.sharedInstance.load()
    }
    
    
}