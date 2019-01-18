//
//  LabelColourPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 28/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIColourPicker: UIStackView, UIColourPickerButtonDelegate {
 
    //MARK: Properties
    @IBInspectable var radius: CGFloat = 34 {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var defaultBorderColour: UIColor = UIColor.black {
        didSet {
            setupButtons()
        }
    }
    
    // delegate
    weak var delegate: UIColourPickerDelegate?
    
    public var chosenColour: UIColor? {
        didSet {
            updateBorder(colour: self.chosenColour)
        }
    }
    
    private var colourButtons = [UIColourPickerButton]()
    
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
        for button in colourButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        colourButtons.removeAll()

        for i in 0..<ThemeColours.labelColours.count {
            
            let button = UIColourPickerButton(colour: ThemeColours.labelColours[i], borderColour: defaultBorderColour.cgColor, radius: radius)
            
            button.delegate = self
            
            addArrangedSubview(button)
            colourButtons.append(button)
        }
    }
    
    func colourSelected(sender: UIColourPickerButton) {
        
        self.chosenColour = sender.colour
        
        self.delegate?.colourSelected(sender: self)
    }
    
    private func updateBorder(colour: UIColor?) {
        
        guard let colour = colour else {
            return
        }
        
        // set all buttons to the default border colour
        for button in self.colourButtons {
            
            if areColoursEqual(colour_1: button.colour, colour_2: colour) {
                button.layer.borderWidth = 3.0
            } else {
                button.layer.borderWidth = 0.0
            }
        }
    }
}
