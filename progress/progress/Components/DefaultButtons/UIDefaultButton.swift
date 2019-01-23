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

    @IBInspectable var normalBackground: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var selectedBackground: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var disabledBackground: UIColor = ThemeColours.textBackground {
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
    
    override var isEnabled: Bool {
        willSet(newValue) {
            if newValue {
                self.backgroundColor = normalBackground
            } else {
                self.backgroundColor = disabledBackground
            }
        }
    }
    
    override var isSelected: Bool {
       willSet(newValue) {
            if newValue {
                self.backgroundColor = selectedBackground
            } else {
                self.backgroundColor = normalBackground
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
        
        self.backgroundColor = self.normalBackground
        
        self.setTitleColor(self.normalTextColour, for: .normal)
        self.setTitleColor(self.selectedTextColour, for: .selected)
        self.setTitleColor(self.disabledTextColour, for: .disabled)
        
        self.addTarget(self, action: #selector(UIDefaultButton.touchedInside(button:)), for: .touchUpInside)
    }
    
    @objc func touchedInside(button: UIDefaultButton) {
        self.selectionVibration.selectionChanged()
    }
}
