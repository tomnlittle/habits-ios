//
//  ViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 17/10/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var mainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTextField.delegate = self
    }
    
    //MARK: Actions
    
    //MARK: Label
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mainLabel.text = "Default Label"
    }
    
    //MARK: UITextFieldDelegate
    // Define functions for the UITextDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        print("returning ...")
        // Hide the keyboard
        textField.resignFirstResponder()
        
        // Indicates whether the system should process the press of the return key
        return true
    }
    
    // Called after the textField has resigned its first responder status
    func textFieldDidEndEditing(_ textField: UITextField) {
        mainLabel.text = textField.text
    }
}

