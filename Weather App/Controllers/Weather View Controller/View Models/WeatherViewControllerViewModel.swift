//
//  WeatherViewControllerViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherViewControllerViewModel {
    
    // MARK: - Private Properties
    private(set) var headerViewModel: WeatherHeaderViewModel?
    private(set) var hourlyForecastViewModel: HourlyForecastViewModel?
    private(set) var dailyForecastViewModel: DailyForecastTableViewModel?
    private(set) var descriptionViewModel: WeatherDescriptionViewModel?
    private(set) var propertiesViewModel: WeatherPropertiesTableViewModel?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(headerViewModel: WeatherHeaderViewModel?,
                  hourlyForecastViewModel: HourlyForecastViewModel?,
                  dailyForecastViewModel: DailyForecastTableViewModel?,
                  descriptionViewModel: WeatherDescriptionViewModel?,
                  propertiesViewModel: WeatherPropertiesTableViewModel?) {
        
        self.headerViewModel = headerViewModel
        self.hourlyForecastViewModel = hourlyForecastViewModel
        self.dailyForecastViewModel = dailyForecastViewModel
        self.descriptionViewModel = descriptionViewModel
        self.propertiesViewModel = propertiesViewModel
    }
    
}
