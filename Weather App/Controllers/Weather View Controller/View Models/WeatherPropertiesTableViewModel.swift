//
//  WeatherPropertiesTableViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherPropertiesTableViewModel {
    
    // MARK: - Private Properties
    private(set) var viewModels: [WeatherPropertyCellViewModel]?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(viewModels: [WeatherPropertyCellViewModel]?) {
        
        self.viewModels = viewModels
    }
    
}
