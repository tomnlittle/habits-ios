//
//  TextButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 8/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class TextButton: UIButton {
    
    @IBInspectable var colour: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = LayerDefaults.defaultRadius {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var heightPadding: CGFloat = 25.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 7.0 {
        didSet {
            setup()
        }
    }
    
    
    //MARK: Initialisation
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Private Methods
    private func setup() {
        
        // set height constraint
        let height = self.titleLabel!.font.pointSize + self.borderWidth + heightPadding
        NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height).isActive = true
        
        // setup the border
        self.layer.cornerRadius = cornerRadius
        
        self.layer.borderColor = colour.cgColor
        self.layer.borderWidth = borderWidth
        
        self.backgroundColor = colour
    }

}
