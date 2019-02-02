//
//  UIDefaultButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 18/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIDefaultButton: UIButton {
    
    // haptic feedback
    private let selectionVibration = UISelectionFeedbackGenerator()

    @IBInspectable var normalBackgroundColour: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var selectedBackgroundColour: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var disabledBackgroundColour: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var normalBorderColour: UIColor = UIColor.white {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var selectedBorderColour: UIColor = UIColor.white {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var disabledBorderColour: UIColor = UIColor.lightGray {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var normalTextColour: UIColor = UIColor.black {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var selectedTextColour: UIColor = UIColor.black {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var disabledTextColour: UIColor = UIColor.lightGray {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
           setup()
        }
    }
    
    override var isEnabled: Bool {
        willSet(newValue) {
            if newValue {
                self.backgroundColor = normalBackgroundColour
                self.layer.borderColor = normalBorderColour.cgColor
            } else {
                self.backgroundColor = disabledBackgroundColour
                self.layer.borderColor = disabledBorderColour.cgColor
            }
        }
    }
    
    override var isSelected: Bool {
       willSet(newValue) {
            if newValue {
                self.backgroundColor = selectedBackgroundColour
                self.layer.borderColor = selectedBorderColour.cgColor
            } else {
                self.backgroundColor = normalBackgroundColour
                self.layer.borderColor = normalBorderColour.cgColor
            }
        }
    }
    
    // MARK: Initialisation
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        self.backgroundColor = self.normalBackgroundColour
        
        self.layer.borderColor = self.normalBorderColour.cgColor
        self.layer.borderWidth = self.borderWidth
        
        self.setTitleColor(self.normalTextColour, for: .normal)
        self.setTitleColor(self.selectedTextColour, for: .selected)
        self.setTitleColor(self.disabledTextColour, for: .disabled)
        
        self.addTarget(self, action: #selector(UIDefaultButton.touchedInside(button:)), for: .touchUpInside)
    }
    
    @objc func touchedInside(button: UIDefaultButton) {
        self.selectionVibration.selectionChanged()
    }
}
