//
//  GoalViewController
//  progress
//
//  Created by Thomas Northall-Little on 17/10/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import os.log

class GoalViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var mainTextField: TextEntryField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var goalDatePicker: UIDatePicker!
    @IBOutlet weak var labelColour: LabelColourPicker!
    
    /*
     This value is either passed by `ProgressionTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new goal.
     */
    var currentGoal: TimeData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextField.delegate = self
        
        // if editing
        if let goal = currentGoal {
            navigationItem.title = goal.name
            mainTextField.text = goal.name
            
            goalDatePicker.date = goal.goalDate
            labelColour.chosenColour = goal.colour
        } else {
            // trigger the keyboard on the text field
            mainTextField.becomeFirstResponder()
        }
        
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    @IBAction func cancelButton(_ sender: Any) {
        //            mainTextField.resignFirstResponder()
        //            mainTextField.endEditing(true)
        
       if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("Not inside a navigation controller.")
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = mainTextField.text ?? ""
        let goalDate = goalDatePicker.date
        let colour = labelColour.chosenColour
        
        self.currentGoal = TimeData(name: name, goalDate: goalDate, colour: colour)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard
        textField.resignFirstResponder()
        
        // Indicates whether the system should process the press of the return key
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let currentString = textField.text else {
            return true
        }
        
        let newLength = currentString.count + string.count - range.length

        if newLength >= mainTextField.maxCharacters {
            return false
        }

        return true
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        textField.text = textField.text?.uppercased()
        updateSaveButtonState()
    }
    
    @IBAction func resetDate(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            self.goalDatePicker.setDate(Date.init(), animated: true)
        }, completion: { (finished: Bool) -> Void in
            sender.layer.removeAllAnimations()
            sender.transform = CGAffineTransform.identity
        })
    }
    
    // MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = self.mainTextField.text ?? ""
        self.saveButton.isEnabled = !text.isEmpty
    }
   
}

