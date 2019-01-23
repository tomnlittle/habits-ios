//
//  LabelColourPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 28/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIColourPicker: UIStackView {
 
    //MARK: Properties
    @IBInspectable var defaultBorderColour: UIColor = UIColor.black {
        didSet {
            setup()
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
    
    override func prepareForInterfaceBuilder() {
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
        for button in colourButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        colourButtons.removeAll()

        for i in 0..<ThemeColours.labelColours.count {
            
            let button = UIColourPickerButton(colour: ThemeColours.labelColours[i], borderColour: defaultBorderColour.cgColor, frame: self.frame)
            
            button.addTarget(self, action: #selector(UIColourPicker.colourSelected(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            colourButtons.append(button)
        }
    }
    
    @objc func colourSelected(button: UIColourPickerButton) {
        
        self.chosenColour = button.colour
        
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
