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

    @IBInspectable var backgroundColour: UIColor = ThemeColours.textBackground {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var unselectedTextColour: UIColor = UIColor.lightGray {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var selectedTextColour: UIColor = UIColor.black {
        didSet {
            setup()
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
        
        self.backgroundColor = self.backgroundColour
        
        self.setTitleColor(self.selectedTextColour, for: .selected)
        self.setTitleColor(self.selectedTextColour, for: .normal)
        
        self.setTitleColor(self.unselectedTextColour, for: .disabled)
        
        self.addTarget(self, action: #selector(UIDefaultButton.touchedInside(button:)), for: .touchUpInside)
    }
    
    @objc func touchedInside(button: UIDefaultButton) {
        self.selectionVibration.selectionChanged()
    }
}
