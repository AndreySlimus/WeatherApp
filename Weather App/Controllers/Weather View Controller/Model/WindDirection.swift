//
//  WindDirection.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

enum WindDirection: String {
    
    static let measure = "м/с"
    
    case northwest = "nw"
    case north = "n"
    case northeast = "ne"
    case east = "e"
    case southeast = "se"
    case south = "s"
    case southwest = "sw"
    case west = "w"
    case calm = "c"
    
    
    private enum WindDirectionDescription: String {
        
        case northwest = "Северо-западный"
        case north = "Северный"
        case northeast = "Северо-восточный"
        case east = "Восточный"
        case southeast = "Юго-восточный"
        case south = "Южный"
        case southwest = "Юго-западный"
        case west = "Западный"
        case calm = "Штиль"
    }
    
    var description: String {
        
        switch self {
        case .northwest:
            return WindDirectionDescription.northwest.rawValue
        case .north:
            return WindDirectionDescription.north.rawValue
        case .northeast:
            return WindDirectionDescription.northeast.rawValue
        case .east:
            return WindDirectionDescription.east.rawValue
        case .southeast:
            return WindDirectionDescription.southeast.rawValue
        case .south:
            return WindDirectionDescription.south.rawValue
        case .southwest:
            return WindDirectionDescription.southwest.rawValue
        case .west:
            return WindDirectionDescription.west.rawValue
        case .calm:
            return WindDirectionDescription.calm.rawValue
        }
    }
    
}
