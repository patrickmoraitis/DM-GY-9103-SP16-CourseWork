//
//  Wager.swift
//  Take 5 Numbers
//
//  Created by Patrick Moraitis on 4/24/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

import UIKit

class Wager: NSObject, NSCoding {
    
// MARK: Properties
    
    struct PropertyKey {
        static let pickKey = "pickK"
        static let dateKey = "dateK"
        static let nameKey = "nameK"
    }
    
    var pickK: [Int] = []
    let dateK: NSDate?
    var nameK: String
    
// MARK: Initialization
    
    init?(pickK: [Int]=[], dateK: NSDate?, nameK: String) {
        // init stored properties
        self.pickK = pickK
        self.dateK = dateK
        self.nameK = nameK
        super.init()
    }
    
    override var description: String {
        return "Name:\(nameK) - DateK: \(dateK ?? "")!"
    }
    
// MARK: Archive Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("wagers")
    
// MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(pickK, forKey: PropertyKey.pickKey)
        aCoder.encodeObject(dateK, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(nameK, forKey: PropertyKey.nameKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        
        let pickK = aDecoder.decodeObjectForKey(PropertyKey.pickKey) as? [Int]
        let dateK = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? NSDate
        let nameK = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as? String
        self.init(pickK: pickK!, dateK: dateK!, nameK: nameK!)
    
    }
    
    
    
    
}//end class