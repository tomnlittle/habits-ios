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
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func save(_ sender: UIButton) {}
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetDate(_ sender: UIButton) {
//        self.currentGoal?.goalDate ??
        let dateToReset =  Date.init()
        
        UIView.animate(withDuration: AnimationConstants.spinDuration, animations: { () -> Void in
            sender.transform = CGAffineTransform(rotationAngle: AnimationConstants.spinMagnitude)
            self.datePicker.setDate(self.resetDate, animated: true)
        }, completion: { (finished: Bool) -> Void in
            sender.layer.removeAllAnimations()
            sender.transform = CGAffineTransform.identity
        })
    }
}
