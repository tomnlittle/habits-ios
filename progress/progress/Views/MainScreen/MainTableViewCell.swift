//
//  ProgressionTableViewCell.swift
//  progress
//
//  Created by Thomas Northall-Little on 21/11/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

class ProgressionTableViewCell: UITableViewCell {
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setup()
        }
    }
    
    // haptic feedback
    let impact = UIImpactFeedbackGenerator()
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    // Initialization code
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.impact.impactOccurred()
            
            UIView.animate(withDuration: AnimationConstants.scaleDuration, animations: { () -> Void in
                self.mainView.transform = CGAffineTransform(scaleX: AnimationConstants.scaleMagnitude, y: AnimationConstants.scaleMagnitude)
            }, completion: { (finished: Bool) -> Void in
                self.mainView.layer.removeAllAnimations()
                self.mainView.transform = CGAffineTransform.identity
            })
        }
    }
    
    public func addGoalInformation(goal: TimeData) {
        nameLabel.text = goal.name
        daysLeft.text = String(getDaysLeft(date: goal.goalDate)) + " DAYS"
        mainView.backgroundColor = goal.colour

        if brightTextOnColour(colour: goal.colour) {
            nameLabel.textColor = UIColor.white
            daysLeft.textColor = UIColor.white
        } else {
            nameLabel.textColor = UIColor.black
            daysLeft.textColor = UIColor.black
        }
    }
    
    private func setup() {
        
        // selection colour
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        // main view radius
        self.mainView.layer.cornerRadius = cornerRadius
        self.mainView.layer.masksToBounds = false
        
        // shadow
        self.mainView.layer.shadowRadius = cornerRadius
        self.mainView.layer.shadowColor = UIColor.darkGray.cgColor
        self.mainView.layer.shadowOffset = CGSize.zero
        self.mainView.layer.shadowOpacity = 0.1
        self.mainView.layer.shadowPath = UIBezierPath(rect: self.mainView.bounds).cgPath
    }
    
    private func getDaysLeft(date: Date) -> Int {
        
        // Day Difference
        let days = Int(date.timeIntervalSinceNow / (60 * 60 * 24))
        
        if days < 0 {
            return -days
        } else {
            return days
        }
    }
}
