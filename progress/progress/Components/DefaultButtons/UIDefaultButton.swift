//
//  UIDefaultButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 18/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIDefaultButton: UIButton {
    
    // haptic feedback
    private let selectionVibration = UISelectionFeedbackGenerator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addTarget(self, action: #selector(UIDefaultButton.touchedInside(button:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchedInside(button: UIDefaultButton) {
        self.selectionVibration.selectionChanged()
    }
}
