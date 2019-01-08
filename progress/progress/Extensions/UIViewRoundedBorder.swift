//
//  UIViewRoundedBorder.swift
//  progress
//
//  Created by Thomas Northall-Little on 8/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

extension UIView {
    func roundAllCorners(radius: CGFloat = LayerDefaults.defaultRadius) {
        self.layer.cornerRadius = radius
    }
}
