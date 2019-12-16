//
//  HourForecastCellType.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/14/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

enum HourForecastCellType: String {
    
    case now
    case hour
    case sunrise
    case sunset
    
    var description: String? {
        
        switch self {
        case .hour:
            return nil
        case .now:
            return "Сейчас"
        case .sunrise:
            return "Восход солнца"
        case .sunset:
            return "Заход солнца"
        }
    }
    
}
