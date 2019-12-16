//
//  WeatherForecast+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import Foundation
import CoreData

extension WeatherForecast {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecast> {
        return NSFetchRequest<WeatherForecast>(entityName: "WeatherForecast")
    }
    
    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var dateString: String?
    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?
    @NSManaged public var unixtime: Double
    @NSManaged public var weather: Weather?
    @NSManaged public var parts: WeatherForecastParts?
    @NSManaged public var hours: NSSet?

}

// MARK: Generated accessors for hours
extension WeatherForecast {

    @objc(addHoursObject:)
    @NSManaged public func addToHours(_ value: WeatherForecastHour)

    @objc(removeHoursObject:)
    @NSManaged public func removeFromHours(_ value: WeatherForecastHour)

    @objc(addHours:)
    @NSManaged public func addToHours(_ values: NSSet)

    @objc(removeHours:)
    @NSManaged public func removeFromHours(_ values: NSSet)

}
