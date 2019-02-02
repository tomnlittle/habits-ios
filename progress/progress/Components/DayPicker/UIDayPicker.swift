//
//  DayPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 10/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIDayPicker: UIStackView {
    
    @IBInspectable var normalBackgroundColour: UIColor = UIColor.white {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var selectedBackgroundColour: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            setup()
        }
    }
    
    // MARK: Private Properties
    
    private var dayButtons: [UIWeekdayButton] = []
    
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
            
            button.selectedBackgroundColour = selectedBackgroundColour
            button.normalBackgroundColour = normalBackgroundColour
            
            button.layer.borderColor = selectedBackgroundColour.cgColor
            button.layer.borderWidth = self.borderWidth
            
            button.isSelected = true
            button.addTarget(self, action: #selector(UIDayPicker.buttonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            dayButtons.append(button)
        }
    }
    
    @objc func buttonTapped(button: UIWeekdayButton) {
        print("day button selected: " + String(button.isSelected))
    }
}
