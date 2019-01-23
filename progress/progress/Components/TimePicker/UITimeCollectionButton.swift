//
//  UITimeCollectionButton.swift
//  progress
//
//  Created by Thomas Northall-Little on 21/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class UITimeCollectionButton: UIRoundedButton {
    
    private var time: String
    
    required init(cell: UICollectionViewCell, time: String) {
        
        self.time = time
        
        // initialise super
        super.init()
        
        self.frame = cell.frame
        self.center = CGPoint(x: cell.frame.width / 2.0, y: cell.frame.height / 2.0)
        self.setTitle(self.time, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        self.addTarget(self, action: #selector(UITimeCollectionButton.cellTouched(button:)), for: .touchUpInside)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cellTouched(button: UITimeCollectionButton) {
        
        print("someone touched me ")
        
    }
}
