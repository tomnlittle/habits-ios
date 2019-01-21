//
//  UIRoundedButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 18/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UIRoundedButton: UIDefaultButton {
    
    @IBInspectable var radius: CGFloat = LayerDefaults.defaultRadius {
        didSet {
            setup()
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    init(radius: CGFloat) {
        super.init(frame: .zero)
    
        self.radius = radius
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = self.radius
        self.clipsToBounds = true
    }
}
