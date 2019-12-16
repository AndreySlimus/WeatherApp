//
//  WeatherHistoryCellPresenter.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherHistoryCellPresenter {
    
    // MARK: - Private Properties
    private let dateFormatter = WeatherDateFormatter()
    private let iconProvider = IconProvider()
    
    // MARK: - Public Methods
    func createViewModel(from weather: Weather) -> WeatherHistoryCellViewModel? {
        
        var curentTemperature, dayTemperature, nightTemperature: String?
    
        let date = dateFormatter.saveWeatherDate(from: weather.unixtime)
        
        if let curentTemperatureValue = weather.state?.temperature {
            curentTemperature = String(curentTemperatureValue).appending("°")
        }
        
        if
            let forecast = (weather.forecasts?.allObjects as? [WeatherForecast])?
                .sorted(by: { $0.unixtime < $1.unixtime })
                .first {
            
            if
                let dayTemperatureValue = forecast.parts?.day?.temperature,
                let nightTemperatureValue = forecast.parts?.night?.temperature {
                
                dayTemperature = String(dayTemperatureValue)
                nightTemperature = String(nightTemperatureValue)
            }
        }
        
        let icon = iconProvider.icon(name: weather.state?.iconName,
                                     weatherCondition: WeatherCondition(rawValue: weather.state?.condition ?? ""))
        
        
        let viewModel = WeatherHistoryCellViewModel.init(date: date,
                                                         location: weather.location?.location,
                                                         currentTemperature: curentTemperature,
                                                         dayTemperature: dayTemperature,
                                                         nightTemperature: nightTemperature,
                                                         picture: icon)
        
        return viewModel
    }
    
}
