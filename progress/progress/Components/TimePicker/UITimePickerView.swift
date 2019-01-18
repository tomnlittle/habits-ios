//
//  TimePicker.swift
//  progress
//
//  Created by Thomas Northall-Little on 11/1/19.
//  Copyright © 2019 Thomas Northall-Little. All rights reserved.
//

import UIKit

@IBDesignable class UITimePickerView: UIView {
    
    // haptic feedback
    let selectionVibration = UISelectionFeedbackGenerator()

    @IBInspectable var spacing: CGFloat = 16 {
        didSet {
//            setup()
        }
    }

    @IBInspectable var cornerRadius: CGFloat = LayerDefaults.defaultRadius {
        didSet {
//            setup()
        }
    }
    
    @IBInspectable var numRows: Int = 3 {
        didSet {
//            setup()
        }
    }

    // unselected colours

    @IBInspectable var unselectedBackgroundColour: UIColor = UIColor.groupTableViewBackground {
        didSet {
//            setup()
        }
    }

    @IBInspectable var unselectedTextColour: UIColor = UIColor.lightGray {
        didSet {
//            setup()
        }
    }

    // selected colours

    @IBInspectable var selectedBackgroundColour: UIColor = UIColor.blue {
        didSet {
//            setup()
        }
    }

    @IBInspectable var selectedTextColour: UIColor = UIColor.black {
        didSet {
//            setup()
        }
    }

    private var selectedTime = 0

    // 2 rows will be in the horizontal view populated with vertical views
    private var verticalView = UIStackView()
    private var horizontalViews = [UIStackView]()

    private var times = ["6am", "7am", "8am", "9am", "4pm", "5pm", "6pm", "7pm", "8pm"]
    private var timeButtons = [UIButton]()

    //MARK: Initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    //MARK: Private Methods
    private func setup() {
        
        print("setting up times")
        
        // remove all the views prior to initialisation
//        cleanViews()
        
        // add the main view
        self.verticalView = setupView(superView: self, orientation: .vertical)
        
        // add the horizontal views to the main view
        setupHorizontalStackViews()
    }
    
    private func cleanViews() {
    
        for view in self.horizontalViews {
            
        }
        
    
        // remove all views
        
        // clear existing buttons
        
        
        for button in timeButtons {
            verticalView.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        timeButtons.removeAll()
        
        // clean up vertical views
        for vView in self.horizontalViews {
            vView.removeFromSuperview()
        }
        
        horizontalViews.removeAll()
        
        // remove vertical view
        verticalView.removeFromSuperview()
        
    }
    
    private func setupView(superView: UIView, orientation: NSLayoutConstraint.Axis) -> UIStackView {
        
        let newStackView = UIStackView()
        
        // setup the main vertical view
        newStackView.axis = orientation
        newStackView.alignment = .fill
        newStackView.distribution  = .fillEqually
        newStackView.spacing = self.spacing
        
        newStackView.backgroundColor = UIColor.lightGray
        
        superView.addSubview(newStackView)
        
        newStackView.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .horizontal {
            newStackView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        } else {
            newStackView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        }
        
        return newStackView
    }
    
    private func setupHorizontalStackViews() {
        
        var currentButtonIndex: Int = 0
        let buttonsPerRow = Int(times.count / self.numRows)
        
        let buttonWidth: CGFloat = 30 //self.verticalView.frame.width / CGFloat(buttonsPerRow)

        for rowIndex in 0..<self.numRows {
        
            let rowView = setupView(superView: self.verticalView, orientation: .horizontal)
            self.horizontalViews.append(rowView)
            
            let maxIndex = ((rowIndex + 1)*buttonsPerRow)
            
            for buttonIndex in currentButtonIndex..<maxIndex {
                
                if buttonIndex > self.times.count {
                    break
                }
    
                let button = UIButton()
    
                // setup button font
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
                button.setTitleColor(self.selectedTextColour, for: .selected)
                button.setTitleColor(self.unselectedTextColour, for: .normal)
                button.setTitle(self.times[buttonIndex], for: .normal)
    
                button.backgroundColor = self.unselectedBackgroundColour
    
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 45).isActive = true
                button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
    
                button.layer.borderWidth = 0.0
                button.layer.cornerRadius = cornerRadius
                button.clipsToBounds = true
    
                button.addTarget(self, action: #selector(UITimePickerView.timeTapped(button:)), for: .touchUpInside)
    
                rowView.addArrangedSubview(button)
                timeButtons.append(button)
                
                currentButtonIndex += 1
            }
        }
    }

    //MARK: Button Action
    @objc func timeTapped(button: UIButton) {
        guard let index = timeButtons.index(of: button) else {
            fatalError("Button \(button) not found")
        }

        print("time tapped")

        button.isSelected = !button.isSelected
        self.selectionVibration.selectionChanged()
    }

    private func updateSelection() {


    }
}
