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
        static let nameKey = "name"
        static let dateKey = "dateK"
    }
    
    var name: String
    let dateK: NSDate?
    
// MARK: Initialization
    
    init?(name: String, dateK: NSDate?) {
        
        // init stored properties
        self.name = name
        self.dateK = dateK
        
        super.init()
    }
    
    override var description: String {
        return "Name:\(name) - DateK: \(dateK ?? "")!"
    }
    
// MARK: Archive Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("wagers")
    
// MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(dateK, forKey: PropertyKey.dateKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let dateK = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? NSDate
        
        self.init(name: name, dateK: dateK)
    }
    
    
    
    
}//end class