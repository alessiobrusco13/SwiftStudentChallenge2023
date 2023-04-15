//
//  ColorNameValue.swift
//  My App
//
//  Created by Alessio Garzia Marotta Brusco on 08/04/23.
//

import Foundation

struct ColorName: Codable, Hashable {
    let name: String
    let hex: String
    let rgb: [Int]
    
    var rgbValues: RGBValues {
        .init(rgb[0], rgb[1], rgb[2])
    }
}
