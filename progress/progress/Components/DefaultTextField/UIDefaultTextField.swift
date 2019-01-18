//
//  TextEntryField.swift
//  progress
//
//  Created by Thomas Northall-Little on 30/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIDefaultTextField: UITextField, UITextFieldDelegate {
    
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
    
    @IBInspectable var borderWidth: CGFloat = 3.0 {
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
    
    @IBInspectable var maxCharacters: Int = 15
    
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
        let paddingWidth = borderWidth + leftPadding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingWidth, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
        // setup the border
        self.layer.cornerRadius = cornerRadius
        
        self.layer.borderColor = colour.cgColor
        self.layer.borderWidth = borderWidth
        
        self.backgroundColor = colour
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.resignFirstResponder()
        
        // Indicates whether the system should process the press of the return key
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentString = textField.text else {
            return true
        }
        
        let newLength = currentString.count + string.count - range.length
        
        if newLength >= self.maxCharacters {
            return false
        }
        
        return true
    }
}
