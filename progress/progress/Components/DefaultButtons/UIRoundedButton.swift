//
//  UIRoundedButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 18/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIRoundedButton: UIDefaultButton {

    init(radius: CGFloat) {
        
        // initialise super
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: radius).isActive = true
        self.widthAnchor.constraint(equalToConstant: radius).isActive = true
        
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = radius / 2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
