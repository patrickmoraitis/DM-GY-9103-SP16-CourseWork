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
            
            if storedWagers.count > 0 {
                allWagers = storedWagers
                //print("data loaded")
            }
            else{
                for _ in 0..<2 {createWager()}
                //print("data loaded is an empty array")
            }
        }
        else{
            for _ in 0..<2 {createWager()}
            print("Error loading saved data, sample data returned instead")
        }
    }
    
    func createWager() -> Wager {
        
        let newWager = Wager(pickK: [1,2,3,4,5], dateK: NSDate(), nameK: "cats")
        //print("created sample wager")

        //allWagers.append(newWager!)
        addWager(newWager!)
        
        //print(newWager)
        return newWager!
    }
    
    func addWager(wager: Wager) {
        allWagers.append(wager)
        //print("added wager")
        
        save()
    }
    
    func removeWagerAtIndex(i: Int) {
        
        //http://stackoverflow.com/questions/24051633/how-to-remove-an-element-from-an-array-in-swift
        allWagers.removeAtIndex((allWagers.count - 1) - i)
        
        save()
         
        //print(allWagers)
        //print("removed wager")

    }
    
    func save() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(allWagers, toFile: Wager.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Error Saving")
        }
        else{
            //print("data saved")
        }
    }
    

    
}//end class
