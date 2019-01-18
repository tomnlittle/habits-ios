//
//  GoalViewController
//  progress
//
//  Created by Thomas Northall-Little on 17/10/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import os.log

class GoalViewController: DefaultModalViewController, UINavigationControllerDelegate, UIColourPickerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var mainTextField: UIDefaultTextField!
    @IBOutlet weak var colourPicker: UIColourPicker!
    @IBOutlet weak var startDatePicker: UITextFieldButton!
    @IBOutlet weak var dayPicker: UIDayPicker!

    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var reminderView: UIView!
    
    // assume initially that the controller is displaying an add new goal screen
    var isEditingGoal: Bool = false
    
    /*
     This value is either passed by `ProgressionTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new goal.
     */
    var currentGoal: GoalData = GoalData(name: "", initialDate: Date.init(), colour: ThemeColours.gunmetal, daysToTrack: [], reminders: [])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colourPicker.delegate = self
        
        // if editing
        if self.isEditingGoal {
            mainTextField.text = self.currentGoal.name
            colourPicker.chosenColour = self.currentGoal.colour
        } else {
        
            // trigger the keyboard on the text field
            mainTextField.becomeFirstResponder()
            
            // hide the colour and date picker initially
            self.colourView.layer.opacity = 0.0
            self.dateView.layer.opacity = 0.0
            self.dayView.layer.opacity = 0.0
            self.reminderView.layer.opacity = 0.0
        }
        
        updateDateButtonText(date: self.currentGoal.initialDate)
    
        // update the save button state -> disabled or enabled
        updateSaveButtonState()
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let button = sender as? UIButton, button === self.saveButton {
            self.currentGoal.name = mainTextField.text ?? ""
            self.currentGoal.colour = colourPicker.chosenColour!
//            self.currentGoal.daysToTrack = dayPicker.selectedBut
        }
        
        if let button = sender as? UIButton, button === self.startDatePicker, let destViewController = segue.destination as? GoalViewDatePickerViewController {
            destViewController.resetDate = self.currentGoal.initialDate
        }
    }
    
    // called when a colour is selected in the colour picker field
    func colourSelected(sender: UIColourPicker) {
        
        // close the keyboard
        self.mainTextField.resignFirstResponder()
        
        // call the animation field again
        animateNextSection()
        
        // update the state of the save button
        updateSaveButtonState()
    }
  
    @IBAction func unwindDatePicker(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? GoalViewDatePickerViewController {

            self.currentGoal.initialDate = sourceViewController.datePicker.date
            updateDateButtonText(date: self.currentGoal.initialDate)
        }
    }

    //MARK: Navigation
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        // upper case the input text
        textField.text = textField.text?.uppercased()
        
        // animate the next section
        animateNextSection()
        
        // update the state of the save button
        updateSaveButtonState()
    }
    
    // MARK: Private Methods
    // Disable the Save button if the text field is empty or if the colour has not yet been selected
    private func updateSaveButtonState() {
        let text = self.mainTextField.text ?? ""
        self.saveButton.isEnabled = !text.isEmpty && self.colourPicker.chosenColour != nil
    }
    
    private func animateNextSection() {
        
        // if we're editing an old goal we dont need to animate as everything is visible
        if self.isEditingGoal {
            return
        }
        
        if self.colourView.layer.opacity == 0.0 {
            UIView.animate(withDuration: AnimationConstants.fadeInDuration, animations: { () -> Void in
                self.colourView.layer.opacity = 1.0
            })
        }
        
        if self.colourPicker.chosenColour != nil {
            UIView.animate(withDuration: AnimationConstants.fadeInDuration, animations: { () -> Void in
                self.dateView.layer.opacity = 1.0
                self.dayView.layer.opacity = 1.0
                self.reminderView.layer.opacity = 1.0
            })
        }
    }
    
    private func updateDateButtonText(date: Date) {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        
        self.startDatePicker.setTitle(formatter.string(from: date), for: .normal)
    }
}

