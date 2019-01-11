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
    
    // Start Date
    var initialDate: Date
    
    // colour of the label
    var colour: UIColor
    
    // what days of the week are we going to track
    var daysToTrack: [EnumDaysOfWeek]
    
    // reminders that have been set by the user
    var reminders: [Int] = []
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("progress")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let initialDate = "initialDate"
        static let colour = "colour"
        static let daysToTrack = "daysToTrack"
        static let reminders = "reminders"
    }
    
    init?(name: String, initialDate: Date, colour: UIColor, daysToTrack: [EnumDaysOfWeek], reminders: [Int]) {
        self.name = name
        self.initialDate = initialDate
        self.colour = colour
        self.daysToTrack = daysToTrack
        self.reminders = reminders
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(initialDate, forKey: PropertyKey.initialDate)
        aCoder.encode(colour, forKey: PropertyKey.colour)
        aCoder.encode(daysToTrack, forKey: PropertyKey.daysToTrack)
        aCoder.encode(reminders, forKey: PropertyKey.reminders)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode Name", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let initialDate = aDecoder.decodeObject(forKey: PropertyKey.initialDate) as? Date else {
            os_log("Unable to decode Date", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let colour = aDecoder.decodeObject(forKey: PropertyKey.colour) as? UIColor else {
            os_log("Unable to decode UIColor", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let daysToTrack = aDecoder.decodeObject(forKey: PropertyKey.daysToTrack) as? [EnumDaysOfWeek] else {
            os_log("Unable to decode UIColor", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let reminders = aDecoder.decodeObject(forKey: PropertyKey.reminders) as? [Int] else {
            os_log("Unable to decode UIColor", log: OSLog.default, type: .debug)
            return nil
        }
     
        self.init(name: name, initialDate: initialDate, colour: colour, daysToTrack: daysToTrack, reminders: reminders)
    }
}
