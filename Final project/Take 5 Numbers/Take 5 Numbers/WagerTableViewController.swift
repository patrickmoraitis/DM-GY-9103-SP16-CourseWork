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
    
    //Reload the table data everytime it appears
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        tableView.reloadData()
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
        
        // Fetches the entire wager store for the data source
        let allWagers = WagerStore.sharedInstance.allWagers
        // select from the array a single data based on indexPath
        
        // uses count - 1 - indexPath to reverse order
        //let wager = allWagers[allWagers.count - 1 - indexPath.row]
        
        //better to use .reverse() intead
        let wager = allWagers.reverse()[indexPath.row]
        
        //set formatter to show date in March 1, 2016 style
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        
        //Adds number & date picked, and default red $1 loss to the cell labels
        cell.pick5Label.text = wager.pickK.map{ "\($0)"}.joinWithSeparator(", ")
        cell.dateLabel.text = formatter.stringFromDate(wager.dateK)
        cell.winlossLabel.text = "-$1"
        
        return cell
    }
    
    // Override to support editing the table view.
    // http://stackoverflow.com/questions/6001852/uitableview-edit-mode
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the view and the data archive
            
            
            WagerStore.sharedInstance.removeWagerAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            //WagerStore.sharedInstance.allWagers.removeAtIndex(indexPath.row)
            
            saveWagers()
        }
        else if editingStyle == .Insert {

        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }

    
    // MARK: NSCoding
    
    //functions call methods of the shared instance to save data or load data.  
    
    func saveWagers(){
        WagerStore.sharedInstance.save()
    }
    
    func loadWagers() {
        WagerStore.sharedInstance.load()
    }
    
    
}