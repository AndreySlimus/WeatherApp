//
//  IconProvider.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/9/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class IconProvider {
    
    private enum WeatherIcons: String {
        
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case cloudy = "cloudy"
        case lightRain = "light-rain"
        case strongRain = "strong-rain"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        case snow = "snow"
        case thunderstorm = "thunderstorm"
    }
    
    private enum ServerWeatherIcons: String {
        
        case clearDay = "skn_d"
        case clearNight = "skn_n"
    }
    
    // MARK: - Public Methods
    func icon(_ phaseSun: PhaseSun) -> UIImage? {
        
        return UIImage.init(named: phaseSun.rawValue)
    }
    
    func icon(name: String?, weatherCondition: WeatherCondition?) -> UIImage? {
        
        switch name {
        case ServerWeatherIcons.clearDay.rawValue:
            return UIImage.init(named: WeatherIcons.clearDay.rawValue)
        case ServerWeatherIcons.clearNight.rawValue:
            return UIImage.init(named: WeatherIcons.clearNight.rawValue)
        default:
            guard
                let weatherCondition = weatherCondition,
                let iconName = iconName(forCondition: weatherCondition)
                else {
                    return nil
            }
            return UIImage.init(named: iconName)
        }
    }
    
    // MARK: - Private Methods
    private func icon(forCondition condition: WeatherCondition) -> UIImage? {
        
        guard let iconName = iconName(forCondition: condition) else { return nil }
        
        return UIImage.init(named: iconName)
    }
    
    private func iconName(forCondition condition: WeatherCondition) -> String? {
        
        switch condition {
        case .clear:
            return WeatherIcons.clearDay.rawValue
        case .overcast:
            return WeatherIcons.cloudy.rawValue
        case .partlyCloudy, .cloudy:
            return WeatherIcons.partlyCloudyDay.rawValue
        case .partlyCloudyAndRain:
            return WeatherIcons.strongRain.rawValue
        case .partlyCloudyAndLightRain,
             .cloudyAndLightRain,
             .overcastAndLightRain,
             .overcastAndRain,
             .cloudyAndRain:
            return WeatherIcons.lightRain.rawValue
        case .overcastThunderstormsWithRain:
            return WeatherIcons.thunderstorm.rawValue
        case .overcastAndWetSnow,
             .overcastAndLightSnow,
             .overcastAndSnow,
             .partlyCloudyAndLightSnow,
             .partlyCloudyAndSnow,
             .cloudyAndSnow,
             .cloudyAndLightSnow:
            return WeatherIcons.snow.rawValue
        case .unknown:
            return WeatherIcons.snow.rawValue
        }
    }
    
}
