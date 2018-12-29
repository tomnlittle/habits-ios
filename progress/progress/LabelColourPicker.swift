//
//  LabelColourPicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 28/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class LabelColourPicker: UIStackView {
    
    //MARK: Properties
    @IBInspectable var boxSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
             setupButtons()
        }
    }
    
    @IBInspectable var defaultBorderColour: UIColor = UIColor.black {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var highlightedBorderColour: UIColor = UIColor.blue {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var defaultBorderWidth: CGFloat = 10.0 {
        didSet {
            setupButtons()
        }
    }
    
    var chosenColour = ThemeColours.defaultLabelColour {
        didSet {
            updateBorderColours()
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
            button.heightAnchor.constraint(equalToConstant: boxSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: boxSize.width).isActive = true

            button.layer.borderColor = defaultBorderColour.cgColor
            button.layer.borderWidth = defaultBorderWidth
            button.layer.cornerRadius = cornerRadius
            button.clipsToBounds = true

            button.addTarget(self, action: #selector(LabelColourPicker.colourTapped(button:)), for: .touchUpInside)

            addArrangedSubview(button)
            colourButtons.append(button)
        }
    }
    
    //MARK: Button Action
    @objc func colourTapped(button: UIButton) {
        guard let index = colourButtons.index(of: button) else {
            fatalError("Button \(button) not found")
        }
        
        chosenColour = ThemeColours.labelColours[index]
    }
    
    private func updateBorderColours() {
        
        // set all buttons to the default border colour
        for (_, button) in colourButtons.enumerated() {

//            print("+++++++++++++++++++++++++++++++++++")
//            print(chosenColour.ciColor == button.backgroundColor!.ciColor)
//            print(button.backgroundColor!.isEqual(chosenColour))
//            print(chosenColour)
//            print(button.backgroundColor!)
            
            if areColoursEqual(colour_1: button.backgroundColor!, colour_2: chosenColour) {
                button.layer.borderColor = highlightedBorderColour.cgColor
            } else {
                button.layer.borderColor = defaultBorderColour.cgColor
            }
           
        }
    }
}
