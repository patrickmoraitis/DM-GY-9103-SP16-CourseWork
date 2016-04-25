//
//  WagerTableViewController.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/24/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class WagerTableViewController: UITableViewController{

    // MARK : Properties
    
    var wagers = [Wager]()
    let pick1 = Wager(name: "1,2,3,4,5")!
    let pick2 = Wager(name: "21,22,23,34,35")!
    let pick3 = Wager(name: "1,12,23,34,37")!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        if wagers.count == 1{
            wagers += [pick1, pick2, pick3]
        }
        
        if let savedWagers = loadWagers(){

            wagers += savedWagers
            
        }else{
            loadSamples()
        }
        
        saveWagers()
    }
    
    func loadSamples() {

    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(wagers.count)
        return wagers.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "WagerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WagerTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let wager = wagers[indexPath.row]
        
        cell.pickLabel.text = wager.name
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            wagers.removeAtIndex(indexPath.row)
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
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(wagers, toFile: Wager.ArchiveURL.path!)
        
        if !isSuccessfulSave {print("Error Saving")}
        
    }
    
    func loadWagers() -> [Wager]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Wager.ArchiveURL.path!) as? [Wager]
    }

    
    
}