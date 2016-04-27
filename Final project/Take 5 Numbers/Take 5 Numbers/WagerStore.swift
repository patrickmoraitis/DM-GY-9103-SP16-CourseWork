//
//  WagerStore.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/26/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class WagerStore {
    
    static let sharedInstance = WagerStore()
    
    var allWagers = [Wager]()
    
    
    func createWager() -> Wager {
        
        let newWager = Wager(pickK: [1,2], dateK: NSDate(), nameK: "cats")
        
        allWagers.append(newWager!)
        
        return newWager!
    }
    
    init(){
        load()
        //for _ in 0..<5 {createWager()}
    }
    
    func add(wager: Wager) {
        allWagers.append(wager)
    }
    
    func save() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allWagers, toFile: Wager.ArchiveURL.path!)
        
        if !isSuccessfulSave {print("Error Saving")}
    }
    
    func load() {
        if let storedWagers = NSKeyedUnarchiver.unarchiveObjectWithFile(Wager.ArchiveURL.path!) as? [Wager] {
            allWagers = storedWagers
        }
    }
    
}//end class
