//
//  GoalViewDatePickerViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 3/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

class GoalViewDatePickerViewController: DefaultOverContextModal {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var controlView: UIView!
    
    var resetDate: Date = Date.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.date = self.resetDate
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetDate(_ sender: UIButton) {

        UIView.animate(withDuration: AnimationConstants.spinDuration, animations: { () -> Void in
            sender.transform = CGAffineTransform(rotationAngle: AnimationConstants.spinMagnitude)
            self.datePicker.setDate(self.resetDate, animated: true)
        }, completion: { (finished: Bool) -> Void in
            sender.layer.removeAllAnimations()
            sender.transform = CGAffineTransform.identity
        })
    }
}
