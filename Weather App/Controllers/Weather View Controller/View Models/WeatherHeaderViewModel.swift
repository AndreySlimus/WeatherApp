//
//  WeatherHeaderViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherHeaderViewModel {
    
    // MARK: - Private Properties
    private(set) var location: String?
    private(set) var condition: String?
    private(set) var temperature: String?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(location: String?,
                  condition: String?,
                  temperature: String?) {
        
        self.location = location
        self.condition = condition
        self.temperature = temperature
    }
    
}
