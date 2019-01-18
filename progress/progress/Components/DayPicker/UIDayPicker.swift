//
//  DayPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 10/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIDayPicker: UIStackView, UIWeekdayButtonDelegate {
    
    // MARK: Designable
    @IBInspectable var radius: CGFloat = 34 {
        didSet {
            setup()
        }
    }
    
    // MARK: Public Properties
    
    // delegate handle
    public var delegate: UIDayPickerDelegate?
    
    // MARK: Private Properties
    
    private var dayButtons: [UIButton] = []
    
    //MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
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

            let button = UIWeekdayButton(day: day, radius: radius)
            
            button.delegate = self
            
            addArrangedSubview(button)
            dayButtons.append(button)
        }
    }
    
    func daySelected(sender: UIWeekdayButton) {
        print("day un/selected")
    }
}