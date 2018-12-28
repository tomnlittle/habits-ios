//
//  ProgressionTableViewCell.swift
//  progress
//
//  Created by Thomas Northall-Little on 21/11/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

class ProgressionTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var daysLeft: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
