//
//  DayOfWeekButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 15/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIWeekdayButton: UIRoundButton {
    
    // delegate
    weak var delegate: UIWeekdayButtonDelegate?

    //MARK: Private Variables
    private var weekday: WeekdayData
   
    // unselected colours
    
    private let unselectedBackgroundColour: UIColor = UIColor.groupTableViewBackground
    private let unselectedTextColour: UIColor = UIColor.lightGray
    
    // selected colours
    
    private let selectedBackgroundColour: UIColor = UIColor.blue
    private let selectedTextColour: UIColor = UIColor.black
    
    required init(day: EnumWeekdays, radius: CGFloat) {
        
        let weekday = WeekdayData(day: day)
        
        // initialise the class
        self.weekday = weekday
        
        // initialise super
        super.init(radius: radius)
        
        self.isSelected = true
        
        // setup button font
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.setTitleColor(self.selectedTextColour, for: .selected)
        self.setTitleColor(self.unselectedTextColour, for: .normal)
        self.setTitle(self.weekday.shortName(), for: .normal)
        
        self.backgroundColor = self.unselectedBackgroundColour
        
        self.addTarget(self, action: #selector(UIWeekdayButton.dayTapped(button:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Button Action
    @objc func dayTapped(button: UIButton) {
        
        button.isSelected = !button.isSelected
        
        // call the delegate
        delegate?.daySelected(sender: self)
    }
    
}
