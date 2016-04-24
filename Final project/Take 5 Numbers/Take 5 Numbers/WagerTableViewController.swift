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

    func loadSamples() {
        let pic1 = UIImage(named: "pic1")!
        let pick1 = Wager(name: "1,2,3,4,5", photo: pic1)!
        
        let pic2 = UIImage(named: "pic2")!
        let pick2 = Wager(name: "21,22,23,34,35", photo: pic2)!
        
        let pic3 = UIImage(named: "pic3")!
        let pick3 = Wager(name: "1,12,23,34,37", photo: pic3)!
        
        wagers += [pick1, pick2, pick3]
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        loadSamples()
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wagers.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "WagerTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! WagerTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let wager = wagers[indexPath.row]
        
        cell.pickLabel.text = wager.name
        cell.picView.image = wager.photo
        
        return cell
    }
    

    
    
}