//
//  UIRoundButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 18/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIRoundButton: UIRoundedButton {
    
    init(frame: CGRect) {
        
        let radius = frame.height 
        
        // initialise super
        super.init(radius: radius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
