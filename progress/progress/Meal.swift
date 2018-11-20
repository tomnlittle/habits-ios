//
//  Meal.swift
//  progress
//
//  Created by Thomas Northall-Little on 21/11/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        if (name.isEmpty || rating < 0) {
            return nil
        }
        
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
