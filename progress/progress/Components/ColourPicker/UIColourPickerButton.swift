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
    
    required init(colour: UIColor, borderColour: CGColor, frame: CGRect) {
        
        self.colour = colour
        
        // initialise super
        super.init(frame: frame)
        
        self.backgroundColor = colour
        self.layer.borderColor = borderColour
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
