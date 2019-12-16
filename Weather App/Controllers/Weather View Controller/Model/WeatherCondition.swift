//
//  WeatherCondition.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

enum WeatherCondition: String {
    
    case clear
    case partlyCloudy = "partly-cloudy"
    case cloudy
    case overcast
    case partlyCloudyAndLightRain = "partly-cloudy-and-light-rain"
    case partlyCloudyAndRain = "partly-cloudy-and-rain"
    case overcastAndRain = "overcast-and-rain"
    case overcastThunderstormsWithRain = "overcast-thunderstorms-with-rain"
    case cloudyAndLightRain = "cloudy-and-light-rain"
    case overcastAndLightRain = "overcast-and-light-rain"
    case cloudyAndRain = "cloudy-and-rain"
    case overcastAndWetSnow = "overcast-and-wet-snow"
    case partlyCloudyAndLightSnow = "partly-cloudy-and-light-snow"
    case partlyCloudyAndSnow = "partly-cloudy-and-snow"
    case overcastAndSnow = "overcast-and-snow"
    case cloudyAndLightSnow = "cloudy-and-light-snow"
    case overcastAndLightSnow = "overcast-and-light-snow"
    case cloudyAndSnow = "cloudy-and-snow"
    case unknown
    
    var description: String {
        
        switch self {
        case .clear:
            return "Ясно"
        case .partlyCloudy:
            return "Малооблачно"
        case .cloudy:
            return "Облачно"
        case .overcast:
            return "Пасмурно"
        case .partlyCloudyAndLightRain, .cloudyAndLightRain, .overcastAndLightRain:
            return "Небольшой дождь"
        case .partlyCloudyAndRain, .cloudyAndRain:
            return "Дождь"
        case .overcastAndRain:
            return "Сильный дождь"
        case .overcastThunderstormsWithRain:
            return "Сильный дождь, гроза"
        case .overcastAndWetSnow:
            return "Дождь со снегом"
        case .partlyCloudyAndLightSnow, .cloudyAndLightSnow, .overcastAndLightSnow:
            return "Небольшой снег"
        case .partlyCloudyAndSnow, .cloudyAndSnow:
            return "Снег"
        case .overcastAndSnow:
            return "Снегопад"
        case .unknown:
            return "Неизвестно"
        }
    }
    
}
