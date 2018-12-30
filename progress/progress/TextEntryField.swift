//
//  TextEntryField.swift
//  progress
//
//  Created by Thomas Northall-Little on 30/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

class TextEntryField: UITextField {
    
    @IBInspectable var colour: UIColor = UIColor.clear {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setup()
        }
    }
    
    let heightPadding: CGFloat = 10.0
    
    //MARK: Initialisation
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Private Methods
    private func setup() {
        
        // set height constraint
        let height = self.font!.pointSize + self.borderWidth + heightPadding
        NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height).isActive = true
    
        // add padding to the left side of the text box
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        // setup the border
        self.layer.cornerRadius = cornerRadius
        
        self.layer.borderColor = colour.cgColor
        self.layer.borderWidth = borderWidth
        
        self.backgroundColor = colour
    }
}
