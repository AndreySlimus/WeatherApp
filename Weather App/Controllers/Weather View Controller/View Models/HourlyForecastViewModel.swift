//
//  HourlyForecastViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class HourlyForecastViewModel {
    
    // MARK: - Private Properties
    private(set) var title: String?
    private(set) var dayTemperature: String?
    private(set) var nightTemperature: String?
    private(set) var hourlyForecasts: [HourForecastViewModel]?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(title: String?,
                  dayTemperature: String?,
                  nightTemperature: String?,
                  hourlyForecasts: [HourForecastViewModel]?) {
        
        self.title = title
        self.dayTemperature = dayTemperature
        self.nightTemperature = nightTemperature
        self.hourlyForecasts = hourlyForecasts
    }
    
}
