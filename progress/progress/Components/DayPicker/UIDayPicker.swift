//
//  DayPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 10/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIDayPicker: UIStackView {
    
    // MARK: Private Properties
    
    private var dayButtons: [UIButton] = []
    
    // MARK: Initialisation
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //MARK: Private Methods
    private func setup() {
        
        // clear existing buttons
        for button in dayButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        dayButtons.removeAll()
        
        for day in EnumWeekdays.allCases {

            let button = UIWeekdayButton(day: day, frame: self.frame)
            
            button.addTarget(self, action: #selector(UIDayPicker.selected(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            dayButtons.append(button)
        }
    }
    
    @objc func selected(button: UIWeekdayButton) {
    
        print("yas")
    }
}
