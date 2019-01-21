//
//  DayOfWeekButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 15/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIWeekdayButton: UIRoundButton {

    //MARK: Private Variables
    private var weekday: WeekdayData
   
    required init(day: EnumWeekdays, frame: CGRect) {
        
        let weekday = WeekdayData(day: day)
        
        // initialise the class
        self.weekday = weekday
        
        // initialise super
        super.init(frame: frame)
        
        self.isSelected = true
        self.setTitle(self.weekday.shortName(), for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.addTarget(self, action: #selector(UIWeekdayButton.dayTapped(button:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Button Action
    @objc func dayTapped(button: UIButton) {
        button.isSelected = !button.isSelected
    }
}
