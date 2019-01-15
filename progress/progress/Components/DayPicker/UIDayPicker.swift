//
//  DayPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 10/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIDayPicker: UIStackView {
    
    // MARK: Public Properties
    
    // delegate handle
    public var delegate: UIDayPickerDelegate?
    
    // MARK: Private Properties
    
    private var selectedDays: [Int] = [] {
        didSet {
            updateSelection()
        }
    }
    
    private var days: [String] = []
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
        
        
        let button = DayOfWeekButton(dayOfWeek: DayOfWeek(day: EnumDaysOfWeek.monday), radius: 34)
        
        addArrangedSubview(button)
        dayButtons.append(button)
        
//        for i in 0..<self.days.count {
//
//        }
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
