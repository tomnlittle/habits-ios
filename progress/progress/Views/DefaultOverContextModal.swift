//
//  DefaultOverContextModal.swift
//  progress
//
//  Created by Thomas Northall-Little on 8/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class DefaultOverContextModal: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if animated {
            UIView.animate(withDuration: AnimationConstants.fadeInDuration, animations: { () -> Void in
                self.view.backgroundColor = ThemeColours.overContextBackgroundColour
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.clear
    }
}
