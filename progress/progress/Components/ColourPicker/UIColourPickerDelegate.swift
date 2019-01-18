//
//  LabelColourPickerDelegateViewController.swift
//  progress
//
//  Created by Thomas Northall-Little on 2/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

protocol UIColourPickerDelegate: AnyObject {
    func colourSelected(sender: UIColourPicker)
}
