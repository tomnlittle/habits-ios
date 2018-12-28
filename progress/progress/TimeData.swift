//
//  Meal.swift
//  progress
//
//  Created by Thomas Northall-Little on 21/11/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import os.log

class TimeData: NSObject, NSCoding {
    
    // MARK: Properties
    
    // Name of the Goal
    var name: String
    
    // Finish Date
    var goalDate: Date
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("time")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let goalDate = "goalDate"
    }
    
    init?(name: String, goalDate: Date) {
        
        if (name.isEmpty) {
            return nil
        }
        
        self.name = name
        self.goalDate = goalDate
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(goalDate, forKey: PropertyKey.goalDate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let goalDate = aDecoder.decodeObject(forKey: PropertyKey.goalDate) as? Date else {
            os_log("Unable to decode date", log: OSLog.default, type: .debug)
            return nil
        }
     
        self.init(name: name, goalDate: goalDate)
    }
}
