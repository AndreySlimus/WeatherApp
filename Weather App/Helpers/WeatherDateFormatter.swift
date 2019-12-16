//
//  WeatherDateFormatter.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class WeatherDateFormatter {
    
    // MARK: - Constants
    private struct Constants {
        
        static let standardLocale = "ru_BY"
        static let standardDayFormat = "EEEE"
        static let standardSaveWeatherDateFormat = "d MMMM yyyy, H:mm, EEEE"
        static let standardPhaseSunDateFormat = "yyyy-MM-dd HH:mm"
    }
    
    // MARK: - Private Properties
    private let dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: Constants.standardLocale)
        
        return dateFormatter
        
    }()

    // MARK: - Public Methods
    func dayName(from unixtime: Double) -> String {
        
        let date = Date.init(timeIntervalSince1970: unixtime)
        
        self.dateFormatter.dateFormat = Constants.standardDayFormat
        
        return self.dateFormatter.string(from: date)
    }
    
    func saveWeatherDate(from unixtime: Double) -> String {
    
        let date = Date.init(timeIntervalSince1970: unixtime)
    
        self.dateFormatter.dateFormat = Constants.standardSaveWeatherDateFormat
    
        return self.dateFormatter.string(from: date)
    }
    
    func datePhaseSun(dateString: String, timeString: String) -> Date? {
        
        self.dateFormatter.dateFormat = Constants.standardPhaseSunDateFormat
        dateFormatter.timeZone = TimeZone.current
        
        return dateFormatter.date(from: "\(dateString) \(timeString)")
    }
    
}
