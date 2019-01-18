//
//  UITimeCollectionViewCell.swift
//  progress
//
//  Created by Thomas Northall-Little on 13/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UITimeCollectionViewCell: UICollectionViewCell {
    
    @IBInspectable var cornerRadius: CGFloat = LayerDefaults.defaultRadius {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
//        let button = UIRoundButton(radius: cornerRadius)
//        
//        print(self.frame)
//        
//        button.backgroundColor = UIColor.black
//        button.center = CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0)
//        button.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.width, height: self.frame.height)
////        button.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0.0).isActive = true
////        button.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0.0).isActive = true
////        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0.0).isActive = true
////        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0.0).isActive = true
////        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0).isActive = true
//        
//        self.addSubview(button)
    }
}
