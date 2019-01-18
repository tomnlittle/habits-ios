//
//  UIColourPickerButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 16/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIColourPickerButton: UIButton {
    
    public var colour: UIColor
    
    // delegate
    weak var delegate: UIColourPickerButtonDelegate?

    //MARK: Private Variables
  
    // haptic feedback
    private let selectionVibration = UISelectionFeedbackGenerator()
    
    required init(colour: UIColor, borderColour: CGColor, radius: CGFloat) {
        
        self.colour = colour
        
        // initialise super
        super.init(frame: .zero)
        
        self.backgroundColor = colour
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: radius).isActive = true
        self.widthAnchor.constraint(equalToConstant: radius).isActive = true
        
        self.layer.borderColor = borderColour
        self.layer.cornerRadius = radius / 2
        self.clipsToBounds = true
        
        self.addTarget(self, action: #selector(UIColourPickerButton.colourTapped(button:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Button Action
    @objc func colourTapped(button: UIButton) {
        
        print(button.isSelected)
        
        self.selectionVibration.selectionChanged()
        
        // run the delegate function
        delegate?.colourSelected(sender: self)
    }
}
