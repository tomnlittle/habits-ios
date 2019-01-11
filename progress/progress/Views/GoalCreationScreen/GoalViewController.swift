//
//  GoalViewController
//  progress
//
//  Created by Thomas Northall-Little on 17/10/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit
import os.log

class GoalViewController: DefaultModalViewController, UITextFieldDelegate, UINavigationControllerDelegate, LabelColourPickerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var mainTextField: TextEntryField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var labelColour: LabelColourPicker!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var dateView: UIView!
    
    // assume initially that the controller is displaying an add new goal screen
    var isEditingGoal: Bool = false
    
    /*
     This value is either passed by `ProgressionTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new goal.
     */
    var currentGoal: GoalData = GoalData(name: "", initialDate: Date.init(), colour: ThemeColours.gunmetal, daysToTrack: [], reminders: [])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextField.delegate = self
        labelColour.delegate = self
        
        // if editing
        if self.isEditingGoal {
            mainTextField.text = self.currentGoal.name
            labelColour.chosenColour = self.currentGoal.colour
        } else {
        
            // trigger the keyboard on the text field
            mainTextField.becomeFirstResponder()
            
            // hide the colour and date picker initially
            self.colourView.layer.opacity = 0.0
            self.dateView.layer.opacity = 0.0
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
            self.currentGoal.colour = labelColour.chosenColour!
        }
        
        if let button = sender as? UIButton, button === self.dateButton, let destViewController = segue.destination as? GoalViewDatePickerViewController {
            destViewController.resetDate = self.currentGoal.initialDate
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
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
        
        // animate the next section
        self.animateNextSection()

        return true
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        // upper case the input text
        textField.text = textField.text?.uppercased()
        
        // update the state of the save button
        updateSaveButtonState()
    }
    
    @IBAction func unwindDatePicker(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? GoalViewDatePickerViewController {

            self.currentGoal.initialDate = sourceViewController.datePicker.date
            updateDateButtonText(date: self.currentGoal.initialDate)
        }
    }
    
    // called when a colour is selected in the colour picker field
    func colourSelected(sender: LabelColourPicker) {
        
        // close the keyboard
        self.mainTextField.resignFirstResponder()
        
        // call the animation field again
        animateNextSection()
        
        // update the state of the save button
        updateSaveButtonState()
    }
    
    //MARK: Navigation
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private Methods
    // Disable the Save button if the text field is empty or if the colour has not yet been selected
    private func updateSaveButtonState() {
        let text = self.mainTextField.text ?? ""
        self.saveButton.isEnabled = !text.isEmpty && self.labelColour.chosenColour != nil
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
        
        if self.labelColour.chosenColour != nil {
            UIView.animate(withDuration: AnimationConstants.fadeInDuration, animations: { () -> Void in
                self.dateView.layer.opacity = 1.0
            })
        }
    }
    
    private func updateDateButtonText(date: Date) {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        
        self.dateButton.setTitle(formatter.string(from: date), for: .normal)
    }
}

