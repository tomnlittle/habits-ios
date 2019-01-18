//
//  EnumDaysOfWeek.swift
//  progress
//
//  Created by Thomas Northall-Little on 11/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

enum EnumWeekdays: String, CaseIterable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}

class WeekdayData {
    
    private var day: EnumWeekdays
    private static let shortNameLength = 3
    
    required init(day: EnumWeekdays) {
        self.day = day
    }
    
    func shortName() -> String {
        let string = self.day.rawValue
        return String(string.prefix(WeekdayData.shortNameLength))
    }
}
