//
//  Colours.swift
//  progress
//
//  Created by Thomas Northall-Little on 28/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

struct ThemeColours {
    
    static let red = UIColor(red:1.00, green:0.28, blue:0.58, alpha:1.0) // #FF4793
    static let green = UIColor(red:0.15, green:1.00, blue:0.32, alpha:1.0) // #26FF51
    static let purple = UIColor(red:0.34, green:0.16, blue:0.88, alpha:1.0) // #5628E0
    
    static let lightGrey = UIColor(red:0.71, green:0.76, blue:0.86, alpha:1.0) // #B6C3DB
    static let grey = UIColor(red:0.17, green:0.18, blue:0.26, alpha:1.0) // #2B2D42
    
    static let defaultLabelColour = lightGrey
    
    static let labelColours = [
        lightGrey,
        grey,
        green,
        red,
        purple
    ]
}

private func hashColour(colour: UIColor) -> Int {
    
    var hue: CGFloat = 0
    var alpha: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0

    
    colour.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
    
    // Apply Cantors Theorem Twice ? https://en.wikipedia.org/wiki/Pairing_function
    
    hue = round(hue * 100)
    alpha = round(alpha * 100)
    saturation = round(saturation * 100)
    brightness = round(brightness * 100)
    
    let cantorHueAlpha = 1/2 * (hue + alpha)*(hue + alpha + 1) + alpha
    let cantorSatBright = 1/2 * (saturation + brightness) * (saturation + brightness + 1) + brightness
    
    let finalCantor = 1/2 * (cantorHueAlpha + cantorSatBright) * (cantorHueAlpha + cantorSatBright + 1) + cantorSatBright
    
    print(cantorHueAlpha)
    print(cantorSatBright)
    
    return Int(finalCantor)
}

public func areColoursEqual(colour_1: UIColor, colour_2: UIColor) -> Bool {
    print("++++++++++++++")
    
    print(hashColour(colour: colour_1))
    print(hashColour(colour: colour_2))
    
    print()
    print(colour_1)
    print(colour_2)
    
    return hashColour(colour: colour_1) == hashColour(colour: colour_2)
}
