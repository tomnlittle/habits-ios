//
//  UiDayPickerDelegate.swift
//  progress
//
//  Created by Thomas Northall-Little on 13/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

protocol UIDayPickerDelegate: AnyObject {
    func selectedDays(sender: UIDayPicker)
}

