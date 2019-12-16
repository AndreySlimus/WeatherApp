//
//  WeatherPropertyCellViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherPropertyCellViewModel {
    
    // MARK: - Private Properties
    private(set) var parameter: String?
    private(set) var value: String?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(parameter: String?,
                  value: String?) {
        
        self.parameter = parameter
        self.value = value
    }
    
}
