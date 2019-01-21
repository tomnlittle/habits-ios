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
        
        let radius = frame.height / 2
        
        // initialise super
        super.init(radius: radius)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: frame.height).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
