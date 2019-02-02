//
//  UIColourPickerButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 16/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UIColourPickerButton: UIRoundButton {
    
    public var colour: UIColor
    
    required init(colour: UIColor, borderWidth: CGFloat, frame: CGRect) {
        
        self.colour = colour
        
        // initialise super
        super.init(frame: frame)
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = colour.cgColor
    
        let scale: CGFloat = borderWidth * CGFloat.pi
        let newDimensions: CGFloat = self.frame.size.height - scale

        let circlePath = UIBezierPath(ovalIn: CGRect(x: scale/2,
                                                     y: scale/2,
                                                     width: newDimensions,
                                                     height: newDimensions))
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = borderWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
