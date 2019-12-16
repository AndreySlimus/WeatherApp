//
//  WeatherForecastHour+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import Foundation
import CoreData

extension WeatherForecastHour {
    
    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecastHour> {
        return NSFetchRequest<WeatherForecastHour>(entityName: "WeatherForecastHour")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var hour: String?
    @NSManaged public var iconName: String?
    @NSManaged public var precipitation: Double
    @NSManaged public var temperature: Int16
    @NSManaged public var unixtime: Double
    @NSManaged public var condition: String?
    @NSManaged public var forecast: WeatherForecast?

}
