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
    
    init(){
        load()
    }
    
    func load() {
        if let storedWagers = NSKeyedUnarchiver.unarchiveObjectWithFile(Wager.ArchiveURL.path!) as? [Wager] {
            allWagers = storedWagers
            print("data loaded")
        }
        else{
            for _ in 0..<2 {createWager()}
            print("Error loading saved data, sample data returned instead")
        }
    }
    
    func createWager() -> Wager {
        
        let newWager = Wager(pickK: [1,2,3,4,5], dateK: NSDate(), nameK: "cats")
        
        allWagers.append(newWager!)
        
        //print(newWager)
        print("created sample wager")
        return newWager!
    }
    
    func addWager(wager: Wager) {
        allWagers.append(wager)
        print("added wager")
        
        save()
    }
    
    func removeWagerAtIndex(i: Int) {
        allWagers.removeAtIndex(0)
        save()
        
        //print(allWagers)
        print("removed wager")

    }
    
    func save() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allWagers, toFile: Wager.ArchiveURL.path!)
        if !isSuccessfulSave {print("Error Saving")}
        else{print("data saved")}
    }
    

    
}//end class
