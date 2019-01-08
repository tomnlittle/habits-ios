//
//  TimeData.swift
//  progress
//
//  Created by Thomas Northall-Little on 21/11/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import CoreData
import os.log

class TimeData: NSObject, NSCoding {
    
    // MARK: Properties
    
    // Name of the Goal
    var name: String
    
    // Finish Date
    var goalDate: Date
    
    // colour of the label
    var colour: UIColor
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("progress")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let goalDate = "goalDate"
        static let colour = "colour"
    }
    
    init?(name: String, goalDate: Date, colour: UIColor) {
        self.name = name
        self.goalDate = goalDate
        self.colour = colour
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(goalDate, forKey: PropertyKey.goalDate)
        aCoder.encode(colour, forKey: PropertyKey.colour)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode Name", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let goalDate = aDecoder.decodeObject(forKey: PropertyKey.goalDate) as? Date else {
            os_log("Unable to decode Date", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let colour = aDecoder.decodeObject(forKey: PropertyKey.colour) as? UIColor else {
            os_log("Unable to decode UIColor", log: OSLog.default, type: .debug)
            return nil
        }
     
        self.init(name: name, goalDate: goalDate, colour: colour)
    }
}
