//
//  Colours.swift
//  progress
//
//  Created by Thomas Northall-Little on 28/12/18.
//  Copyright © 2018 Thomas Northall-Little. All rights reserved.
//

import UIKit

struct ThemeColours {
    
    static let overContextBackgroundColour = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)
    static let modalBackgroundColour = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.3)
    static let textBackground = UIColor.groupTableViewBackground
    
    static let saveButtonColour = UIColor(red:0.20, green:0.71, blue:1.00, alpha:1.0) // #33B5FF // #33D1FF
    
    // REDS
    static let begonia = UIColor(red:1.00, green:0.42, blue:0.47, alpha:1.0) // Red -> #FF6C78
    
    // GREENS
    static let pistachio = UIColor(red:0.59, green:0.92, blue:0.44, alpha:1.0) // Green -> #96EA6F
    
    // YELLOWS
    static let yellow = UIColor(red:1.00, green:0.85, blue:0.45, alpha:1.0) // #FFD874
    
    // BLUES/PURPLES
    static let queenBlue = UIColor(red:0.25, green:0.40, blue:0.65, alpha:1.0) // #3F66A5
    static let paynesGrey = UIColor(red:0.29, green:0.43, blue:0.49, alpha:1.0) // Bluey Grey #4A6D7C
    
    // GREYS
    static let lightBlueSteel = UIColor(red:0.71, green:0.76, blue:0.86, alpha:1.0) // #B6C3DB
    static let gunmetal = UIColor(red:0.17, green:0.18, blue:0.26, alpha:1.0) // #2B2D42
    
    static let blue = UIColor(red:0.20, green:0.55, blue:1.00, alpha:1.0) // #338CFF
    
    static let labelColours = [
        // REDS
        begonia,
       
        // GREENS
        pistachio,
        
        // YELLOWS
        yellow,
       
        // BLUES
        blue,
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
    
    let cantorHueAlpha = 1/2 * (hue + alpha) * (hue + alpha + 1) + alpha
    let cantorSatBright = 1/2 * (saturation + brightness) * (saturation + brightness + 1) + brightness
    
    let finalCantor = 1/2 * (cantorHueAlpha + cantorSatBright) * (cantorHueAlpha + cantorSatBright + 1) + cantorSatBright
    
    return Int(finalCantor)
}

public func areColoursEqual(colour_1: UIColor, colour_2: UIColor) -> Bool {
    return hashColour(colour: colour_1) == hashColour(colour: colour_2)
}

public func brightTextOnColour(colour: UIColor) -> Bool {
    // calculate when to use black text on the background or white text
    // https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color/3943023
    
    var L: CGFloat = 0.0
    var R: CGFloat = 0.0
    var G: CGFloat = 0.0
    var B: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    
    colour.getRed(&R, green: &G, blue: &B, alpha: &alpha)
    
    R = R <= 0.03928 ? R/12.92 : pow(((R + 0.055)/1.055), 2.4)
    G = G <= 0.03928 ? G/12.92 : pow(((G + 0.055)/1.055), 2.4)
    B = B <= 0.03928 ? B/12.92 : pow(((B + 0.055)/1.055), 2.4)
    
    L = 0.2126 * R + 0.7152 * G + 0.0722 * B
    
    return L < 0.179
}
