//
//  progressTests.swift
//  progressTests
//
//  Created by Thomas Northall-Little on 17/10/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import XCTest
@testable import progress

class progressTests: XCTestCase {
    
    //MARK: Data Model Testing
    
    // Check initialisation
    func testMealInitialisationSucceeds() {
        let ratingZero = Meal.init(name: "A name", photo: nil, rating: 0)
        XCTAssertNotNil(ratingZero)
    }
    
    func testMealInitialisationFails() {
        let ratingNegative = Meal.init(name: "Nil Sample", photo: nil, rating: -1)
        XCTAssertNil(ratingNegative)
        
        let noName = Meal.init(name: "", photo: nil, rating: -1)
        XCTAssertNil(noName)
    }

}
