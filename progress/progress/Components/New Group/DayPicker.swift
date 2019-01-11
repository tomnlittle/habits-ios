//
//  DayPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 10/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

enum DaysOfWeek {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

@IBDesignable class DayPicker: UIStackView {
    
    // haptic feedback
    let selectionVibration = UISelectionFeedbackGenerator()
    
    //MARK: Properties
    @IBInspectable var boxSize: CGFloat = 34 {
        didSet {
            setupButtons()
        }
    }
    
    // unselected colours
    
    @IBInspectable var unselectedBackgroundColour: UIColor = UIColor.groupTableViewBackground {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var unselectedTextColour: UIColor = UIColor.lightGray {
        didSet {
            setupButtons()
        }
    }
    
    // selected colours
    
    @IBInspectable var selectedBackgroundColour: UIColor = UIColor.blue {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var selectedTextColour: UIColor = UIColor.black {
        didSet {
            setupButtons()
        }
    }
    
    private var selectedDays: [Int?] = [] {
        didSet {
            updateSelection()
        }
    }
    
    private var days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private var dayButtons = [UIButton]()
    
    //MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        // clear existing buttons
        for button in dayButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        dayButtons.removeAll()
        
        for i in 0..<self.days.count {
            
            let button = UIButton()
            
            button.isSelected = true
            
            // setup button font
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
            button.setTitleColor(self.selectedTextColour, for: .selected)
            button.setTitleColor(self.unselectedTextColour, for: .normal)
            button.setTitle(self.days[i], for: .normal)
            
            button.backgroundColor = self.unselectedBackgroundColour
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: boxSize).isActive = true
            button.widthAnchor.constraint(equalToConstant: boxSize).isActive = true
            
            button.layer.borderWidth = 0.0
            button.layer.cornerRadius = boxSize / 2
            button.clipsToBounds = true
            
            button.addTarget(self, action: #selector(DayPicker.dayTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            dayButtons.append(button)
        }
        
//        updateSelection()
    }
    
    //MARK: Button Action
    @objc func dayTapped(button: UIButton) {
        guard let index = dayButtons.index(of: button) else {
            fatalError("Button \(button) not found")
        }
        
        button.isSelected = !button.isSelected
        self.selectionVibration.selectionChanged()
    }
    
    private func updateSelection() {
        
        // clear selected array
        self.selectedDays = []
        
        for button in self.dayButtons {
            if button.isSelected {
//                self.selectedDays.append(button)
            }
        }

    }

}
