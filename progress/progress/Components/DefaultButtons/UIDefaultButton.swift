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

    private var backgroundColour: UIColor = UIColor.groupTableViewBackground
    private var unselectedTextColour: UIColor = UIColor.lightGray
    private var selectedTextColour: UIColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitleColor(self.selectedTextColour, for: .selected)
        self.setTitleColor(self.unselectedTextColour, for: .normal)
        self.setTitleColor(self.unselectedTextColour, for: .disabled)
        
        self.backgroundColor = self.backgroundColour
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    private func setupButton() {
        self.addTarget(self, action: #selector(UIDefaultButton.touchedInside(button:)), for: .touchUpInside)
    }
    
    @objc func touchedInside(button: UIDefaultButton) {
        self.selectionVibration.selectionChanged()
    }
}
