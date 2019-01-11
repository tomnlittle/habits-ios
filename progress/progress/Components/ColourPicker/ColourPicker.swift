//
//  LabelColourPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 28/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class LabelColourPicker: UIStackView {
    
    // haptic feedback
    let selectionVibration = UISelectionFeedbackGenerator()
    
    //MARK: Properties
    @IBInspectable var boxSize: CGFloat = 34 {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var defaultBorderColour: UIColor = UIColor.black {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var defaultBorderWidth: CGFloat = 3 {
        didSet {
            setupButtons()
        }
    }
    
    // delegate
    weak var delegate: LabelColourPickerDelegate?
    
    var chosenColour: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    private var colourButtons = [UIButton]()
    
    //MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    private func setupButtons() {
        
        // clear existing buttons
        for button in colourButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        colourButtons.removeAll()

        for i in 0..<ThemeColours.labelColours.count {
            
            let button = UIButton()
            
            button.backgroundColor = ThemeColours.labelColours[i]

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: boxSize).isActive = true
            button.widthAnchor.constraint(equalToConstant: boxSize).isActive = true

            button.layer.borderColor = defaultBorderColour.cgColor
            button.layer.cornerRadius = boxSize / 2
            button.clipsToBounds = true

            button.addTarget(self, action: #selector(LabelColourPicker.colourTapped(button:)), for: .touchUpInside)

            addArrangedSubview(button)
            colourButtons.append(button)
        }
        
        // update the border width
        updateBorder()
    }
    
    //MARK: Button Action
    @objc func colourTapped(button: UIButton) {
        guard let index = colourButtons.index(of: button) else {
            fatalError("Button \(button) not found")
        }
        
        chosenColour = ThemeColours.labelColours[index]
        
        // run the delegate function
        delegate?.colourSelected(sender: self)
    }
    
    private func updateBorder() {
        
        // check if colour is unwrappable
        guard let colour = self.chosenColour else {
            return
        }
        
        self.selectionVibration.selectionChanged()
        
        // set all buttons to the default border colour
        for (_, button) in colourButtons.enumerated() {
    
            if areColoursEqual(colour_1: button.backgroundColor!, colour_2: colour) {
                button.layer.borderWidth = defaultBorderWidth
            } else {
                button.layer.borderWidth = 0.0
            }
        }
    }
}
