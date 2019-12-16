//
//  ViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherViewControllerPresenter {
    
    let dateFormatter = WeatherDateFormatter()
    let iconProvider = IconProvider()
    
    func createViewModel(from weather: Weather) -> WeatherViewControllerViewModel {
        
        let headerViewModel = createHeaderViewModel(from: weather)
        let hourlyForecastViewModel = createHourlyForecastViewModel(from: weather)
        let dailyForecastViewModel = createDailyForecastTableViewModel(from: weather)
        let descriptionViewModel = createWeatherDescriptionViewModel(from: weather)
        let propertiesViewModel = createWeatherPropertiesTableViewModel(from: weather)
        
        let viewModel = WeatherViewControllerViewModel.init(headerViewModel: headerViewModel,
                                                            hourlyForecastViewModel: hourlyForecastViewModel,
                                                            dailyForecastViewModel: dailyForecastViewModel,
                                                            descriptionViewModel: descriptionViewModel,
                                                            propertiesViewModel: propertiesViewModel)
        
        return viewModel
    }
    
    private func createHeaderViewModel(from weather: Weather) -> WeatherHeaderViewModel {
        
        var condition, temperature: String?
        
        if let temperatureValue = weather.state?.temperature {
            temperature = String(temperatureValue).appending("°")
        }
        
        if let conditionValue = weather.state?.condition {
            condition = WeatherCondition(rawValue: conditionValue)?.description
        }
        
        let headerViewModel = WeatherHeaderViewModel.init(location: weather.location?.location?.capitalized,
                                                          condition: condition,
                                                          temperature: temperature)
        
        return headerViewModel
    }
    
    private func createHourlyForecastViewModel(from weather: Weather) -> HourlyForecastViewModel? {
        
        var day, dayTemperature, nightTemperature: String?
        var forecastHours = [WeatherForecastHour]()
        var forecastHoursViewModels = [HourForecastViewModel]()
        
        guard
            let forecasts = (weather.forecasts?.allObjects as? [WeatherForecast])?
            .sorted(by: { $0.unixtime < $1.unixtime })
            .prefix(2)
            else {
                return nil
        }
        
        guard
            let todayHours = (forecasts.first?.hours?.allObjects as? [WeatherForecastHour])?
            .sorted(by: { $0.unixtime < $1.unixtime }),
            let tomorrowHours = (forecasts.last?.hours?.allObjects as? [WeatherForecastHour])?
            .sorted(by: { $0.unixtime < $1.unixtime })
            else {
                return nil
        }
        
        guard let currentHourIndex = todayHours.firstIndex(where: { $0.unixtime > weather.unixtime }) else {
            return nil
        }
        
        forecastHours.append(contentsOf: todayHours[(currentHourIndex - 1)...])
        
        forecastHours.append(contentsOf: tomorrowHours[...(24 - forecastHours.count)])
        
        for (index, forecastHour) in forecastHours.enumerated() {
            
            if index == 0 {
                
                let hourForecastViewModel = createHourForecastViewModel(cellType: .now,
                                                                        hour: forecastHour)
                
                forecastHoursViewModels.append(hourForecastViewModel)
                
            } else {
                
                let hourForecastViewModel = createHourForecastViewModel(cellType: .hour,
                                                                        hour: forecastHour)
                
                forecastHoursViewModels.append(hourForecastViewModel)
            }
        }
        
        day = self.dateFormatter.dayName(from: weather.unixtime).capitalized
        
        if let dayTemperatureValue = forecasts.first?.parts?.day?.temperature {
            dayTemperature = String(dayTemperatureValue)
        }
        
        if let nightTemperatureValue = forecasts.first?.parts?.night?.temperature {
            nightTemperature = String(nightTemperatureValue)
        }
        
        guard
            let todayDateString = forecasts.first?.dateString,
            let todaySunriseDateString = forecasts.first?.sunrise,
            let todaySunsetDateString = forecasts.first?.sunset,
            let todaySunriseDate = self.dateFormatter.datePhaseSun(dateString: todayDateString,
                                                                   timeString: todaySunriseDateString),
            let todaySunsetDate = self.dateFormatter.datePhaseSun(dateString: todayDateString,
                                                                  timeString: todaySunsetDateString),
        
            let tomorrowDateString = forecasts.last?.dateString,
            let tomorrowSunriseDateString = forecasts.last?.sunrise,
            let tomorrowSunsetDateString = forecasts.last?.sunset,
            let tomorrowSunriseDate = self.dateFormatter.datePhaseSun(dateString: tomorrowDateString,
                                                                      timeString: tomorrowSunriseDateString),
            let tomorrowSunsetDate = self.dateFormatter.datePhaseSun(dateString: tomorrowDateString,
                                                                     timeString: tomorrowSunsetDateString)
            else {
                return nil
        }
        
        if weather.unixtime < todaySunriseDate.timeIntervalSince1970,
            
            let todatSunriseIndex = forecastHours.firstIndex(where: {
                $0.unixtime > todaySunriseDate.timeIntervalSince1970
            }) {
            
            let viewModel = createPhaseSunViewModel(cellType: .sunrise,
                                                     title: forecasts.first?.sunrise)
            
            forecastHoursViewModels.insert(viewModel, at: todatSunriseIndex)
            
        } else if weather.unixtime < tomorrowSunriseDate.timeIntervalSince1970,
            
            let tommorowSunriseIndex = forecastHours.firstIndex(where: {
                $0.unixtime > tomorrowSunriseDate.timeIntervalSince1970
            }) {
            
            let viewModel = createPhaseSunViewModel(cellType: .sunrise,
                                                     title: forecasts.last?.sunrise)
            
            forecastHoursViewModels.insert(viewModel, at: tommorowSunriseIndex)
        }
        
        if weather.unixtime < todaySunsetDate.timeIntervalSince1970,
            
            let todaySunsetIndex = forecastHours.firstIndex(where: {
                $0.unixtime > todaySunsetDate.timeIntervalSince1970
            }) {
            
            let viewModel = createPhaseSunViewModel(cellType: .sunset,
                                                     title: forecasts.first?.sunset)
            
            forecastHoursViewModels.insert(viewModel, at: todaySunsetIndex)
            
        } else if weather.unixtime < tomorrowSunsetDate.timeIntervalSince1970,
            
            let tommorowSunsetIndex = forecastHours.firstIndex(where: {
                $0.unixtime > tomorrowSunsetDate.timeIntervalSince1970
            }) {
            
            let viewModel = createPhaseSunViewModel(cellType: .sunset,
                                                     title: forecasts.last?.sunset)
            
            forecastHoursViewModels.insert(viewModel, at: tommorowSunsetIndex)
        }
        
        let viewModel = HourlyForecastViewModel.init(title: day,
                                                     dayTemperature: dayTemperature,
                                                     nightTemperature: nightTemperature,
                                                     hourlyForecasts: forecastHoursViewModels)
        
        return viewModel
    }
    
    private func createPhaseSunViewModel(cellType type: HourForecastCellType,
                                         title: String?) -> HourForecastViewModel {
        
        var icon: UIImage?
        
        switch type {
        case .sunrise:
            icon = iconProvider.icon(.sunrise)
        case .sunset:
            icon = iconProvider.icon(.sunset)
        default: break
        }
        
        let descriptionWidth = type.description?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 21)])
        
        let viewModel = HourForecastViewModel.init(type: type,
                                                   title: title,
                                                   precipitation: nil,
                                                   temperature: type.description,
                                                   picture: icon,
                                                   cellWidth: descriptionWidth?.width)
        
        return viewModel
    }
    
    private func createHourForecastViewModel(cellType type: HourForecastCellType,
                                             hour: WeatherForecastHour) -> HourForecastViewModel {
        
        var title, precipitation: String?
        var picture: UIImage?
        var cellWidth: CGFloat?
        
        switch type {
        case .hour:
            title = hour.hour
            cellWidth = HourForecastCell.standaresWidth
        case .now:
            title = type.description
            let titleSize = type.description?.size(withAttributes: [.font: UIFont.systemFont(ofSize: 21)])
            cellWidth = titleSize?.width
        default: break
        }
        
        if hour.precipitation > 0.0 {
            precipitation = String(format: "%.0f", hour.precipitation).appending("%")
        }

        let temperature = String(hour.temperature).appending("°")

        if
            let conditionValue = hour.condition,
            let weatherCondition = WeatherCondition(rawValue: conditionValue),
            let icon = iconProvider.icon(name: hour.iconName, weatherCondition: weatherCondition) {
            picture = icon
        }

        let viewModel = HourForecastViewModel.init(type: type, title: title,
                                                   precipitation: precipitation,
                                                   temperature: temperature,
                                                   picture: picture,
                                                   cellWidth: cellWidth)
        
        return viewModel
    }
    
    private func createWeatherPropertiesTableViewModel(from weather: Weather) -> WeatherPropertiesTableViewModel? {
        
        let viewModel: WeatherPropertiesTableViewModel?
        var cellViewModels = [WeatherPropertyCellViewModel]()
        
        if let precipitationValue = weather.state?.precipitation {
        
            let precipitationString = String(format: "%.0f", precipitationValue).appending(" %")
            
            cellViewModels.append(createWeatherPropertyCellViewModel(withProperty: .precipitation,
                                                                     value: precipitationString))
        }
        
        if let humidity = weather.state?.humidity {
            
            let humidityString = String(humidity).appending(" %")
            
            cellViewModels.append(createWeatherPropertyCellViewModel(withProperty: .humidity,
                                                                     value: humidityString))
        }
        
        if let windSpeed = weather.state?.windSpeed, let windDirection = weather.state?.windDirection {
        
            let windDirectionString = WindDirection.init(rawValue: windDirection)?.description.lowercased()
            let windSpeedString = String(windSpeed)
            
            if let windString = windDirectionString?.appending(", " + windSpeedString + " " + WindDirection.measure) {
                
                cellViewModels.append(createWeatherPropertyCellViewModel(withProperty: .wind,
                                                                         value: windString))
            }
        }
        
        if let feelsTemperature = weather.state?.feelsTemperature {
            
            let feelsTemperatureString = String(feelsTemperature).appending("°")
            
            cellViewModels.append(createWeatherPropertyCellViewModel(withProperty: .feelsTemperature,
                                                                     value: feelsTemperatureString))
        }
        
        if let pressure = weather.state?.pressure {
            
            let pressureString = String(pressure).appending(" мм. рт. ст.")
            
            cellViewModels.append(createWeatherPropertyCellViewModel(withProperty: .pressure,
                                                                     value: pressureString))
        }
        
        if let ultravioletIndex = weather.state?.ultravioletIndex {
            
            let ultravioletIndexString = String(ultravioletIndex)
            
            cellViewModels.append(createWeatherPropertyCellViewModel(withProperty: .ultravioletIndex,
                                                                     value: ultravioletIndexString))
        }
        
        guard
            let forecast = (weather.forecasts?.allObjects as? [WeatherForecast])?
                .sorted(by: { $0.unixtime < $1.unixtime })
                .first
            else {
                return nil
        }
        
        if let sunriseTime = forecast.sunrise {
            
            cellViewModels.insert(createWeatherPropertyCellViewModel(withProperty: .sunrise,
                                                                     value: sunriseTime),
                                  at: 0)
        }
        
        if let sunsetTime = forecast.sunset {
            
            cellViewModels.insert(createWeatherPropertyCellViewModel(withProperty: .sunset,
                                                                     value: sunsetTime),
                                  at: 1)
        }
        
        viewModel = WeatherPropertiesTableViewModel.init(viewModels: cellViewModels)
        
        return viewModel
    }
    
    private func createWeatherPropertyCellViewModel(withProperty property: WeatherProperty,
                                                    value: String) -> WeatherPropertyCellViewModel {
        
        let viewModel = WeatherPropertyCellViewModel.init(parameter: property.rawValue,
                                                          value: value)
        
        return viewModel
    }
    
    private func createDailyForecastTableViewModel(from weather: Weather) -> DailyForecastTableViewModel? {
        
        var viewModels = [DayForecastCellViewModel]()
        
        guard
            let futureForecasts = (weather.forecasts?.allObjects as? [WeatherForecast])?
                .sorted(by: { $0.unixtime < $1.unixtime })
                .dropFirst()
            else {
                return nil
        }
    
        futureForecasts.forEach { forecast in
            
            let viewModel = createDailyForecastCellViewModel(from: forecast)
            
            viewModels.append(viewModel)
        }
        
        let viewModel = DailyForecastTableViewModel.init(viewModels: viewModels)
        
        return viewModel
    }
    
    private func createDailyForecastCellViewModel(from forecast: WeatherForecast) -> DayForecastCellViewModel {
        
        var dayTemperature, nightTemperature: String?
        var picture: UIImage?
        
        let day = self.dateFormatter.dayName(from: forecast.unixtime).capitalized
        
        if let dayTemperatureValue = forecast.parts?.day?.temperature {
            dayTemperature = String(dayTemperatureValue)
        }
        
        if let nightTemperatureValue = forecast.parts?.night?.temperature {
            nightTemperature = String(nightTemperatureValue)
        }
        
        if
            let conditionValue = forecast.parts?.day?.condition,
            let weatherCondition = WeatherCondition(rawValue: conditionValue),
            let icon = iconProvider.icon(name: forecast.parts?.day?.iconName,
                                         weatherCondition: weatherCondition) {
            picture = icon
        }
        
        let viewModel = DayForecastCellViewModel.init(day: day,
                                                      dayTemperature: dayTemperature,
                                                      nightTemperature: nightTemperature,
                                                      picture: picture)
        
        return viewModel
    }
    
    private func createWeatherDescriptionViewModel(from weather: Weather) -> WeatherDescriptionViewModel? {
        
        if
            let conditionValue = weather.state?.condition,
            let condition = WeatherCondition(rawValue: conditionValue)?.description.lowercased(),
            let currentTemperatureValue = weather.state?.temperature,
            let todayForecast = (weather.forecasts?.allObjects as? [WeatherForecast])?
                .sorted(by: { $0.unixtime < $1.unixtime })
                .first,
            let greatestTemperatureValue = (todayForecast.hours?.allObjects as? [WeatherForecastHour])?
                .sorted(by: { $0.temperature > $1.temperature })
                .first?
                .temperature {
            
            let description = "Сегодня: Сейчас \(condition.description). Температура воздуха: \(String(currentTemperatureValue))°. Максимальная температура воздуха \(String(greatestTemperatureValue))°."
            
            let viewModel = WeatherDescriptionViewModel.init(description: description)
            
            return viewModel
            
        } else {
            
            return nil
        }
    }

}
