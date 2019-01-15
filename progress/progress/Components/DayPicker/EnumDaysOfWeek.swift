//
//  EnumDaysOfWeek.swift
//  progress
//
//  Created by Thomas Northall-Little on 11/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

enum EnumDaysOfWeek: String {
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
    case sunday = "sunday"
}

class DayOfWeek {
    
    private var day: EnumDaysOfWeek
    private static let shortNameLength = 3
    
    required init(day: EnumDaysOfWeek) {
        self.day = day
    }
    
    func shortName() -> String {
        let string = self.day.rawValue
        return String(string.prefix(DayOfWeek.shortNameLength))
    }
}
