//
//  DayOfWeekButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 15/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class DayOfWeekButton: UIButton {
    
    //MARK: Private Variables
    
    private var dayOfWeek: DayOfWeek

    // unselected colours
    
    private let unselectedBackgroundColour: UIColor = UIColor.groupTableViewBackground
    private let unselectedTextColour: UIColor = UIColor.lightGray
    
    // selected colours
    
    private let selectedBackgroundColour: UIColor = UIColor.blue
    private let selectedTextColour: UIColor = UIColor.black
    
    // haptic feedback
    private let selectionVibration = UISelectionFeedbackGenerator()
    
    required init(dayOfWeek: DayOfWeek, radius: CGFloat) {
        self.dayOfWeek = dayOfWeek
        
        super.init(frame: .zero)
        
        self.isSelected = true
        
        // setup button font
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.setTitleColor(self.selectedTextColour, for: .selected)
        self.setTitleColor(self.unselectedTextColour, for: .normal)
        self.setTitle(self.dayOfWeek.shortName(), for: .normal)
        
        self.backgroundColor = self.unselectedBackgroundColour
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: radius).isActive = true
        self.widthAnchor.constraint(equalToConstant: radius).isActive = true
        
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = radius / 2
        self.clipsToBounds = true
        
        self.addTarget(self, action: #selector(DayOfWeekButton.dayTapped(button:)), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Button Action
    @objc func dayTapped(button: UIButton) {
        button.isSelected = !button.isSelected
        self.selectionVibration.selectionChanged()
    }
    
}
