//
//  UIColourPickerButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 16/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIColourPickerButton: UIRoundButton {
    
    public var colour: UIColor
    
    // delegate
    weak var delegate: UIColourPickerButtonDelegate?
    
    required init(colour: UIColor, borderColour: CGColor, radius: CGFloat) {
        
        self.colour = colour
        
        // initialise super
        super.init(radius: radius)
        
        self.backgroundColor = colour
        self.addTarget(self, action: #selector(UIColourPickerButton.colourTapped(button:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Button Action
    @objc func colourTapped(button: UIButton) {
        
        // run the delegate function
        delegate?.colourSelected(sender: self)
    }
}
