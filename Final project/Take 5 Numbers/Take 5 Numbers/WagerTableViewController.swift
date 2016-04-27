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
        
        return WagerLog.sharedInstance.allWagers.count
        
    }
    
    //Cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                
        // Get the cell prototyped in the storyboard
        let cellIdentifier = "wagerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WagerTableViewCell
        
        print(WagerLog.sharedInstance.allWagers)
        
        // Fetches the appropriate wager for the data source layout
        let wager = WagerLog.sharedInstance.allWagers[indexPath.row]
        
        cell.pick5Label?.text = wager.name
        cell.dateLabel?.text = wager.dateK?.description
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            WagerLog.sharedInstance.allWagers.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    // MARK: NSCoding
    
    func saveWagers(){
        WagerLog.sharedInstance.save()
    }
    
    func loadWagers() {
        WagerLog.sharedInstance.load()
    }
    
    
}