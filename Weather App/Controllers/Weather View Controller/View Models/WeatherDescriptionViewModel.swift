//
//  WeatherDescriptionViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherDescriptionViewModel {
    
    // MARK: - Private Properties
    private(set) var description: String?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(description: String?) {
        
        self.description = description
    }
    
}
