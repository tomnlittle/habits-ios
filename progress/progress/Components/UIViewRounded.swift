//
//  UIViewRounded.swift
//  progress
//
//  Created by Thomas Northall-Little on 23/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIViewRounded: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = LayerDefaults.defaultRadius {
        didSet {
            setup()
        }
    }

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
        self.layer.cornerRadius = cornerRadius
    }
}
