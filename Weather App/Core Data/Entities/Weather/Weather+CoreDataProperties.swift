//
//  Weather+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import Foundation
import CoreData

extension Weather {
    
    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }
    
    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var dateString: String?
    @NSManaged public var unixtime: Double
    @NSManaged public var state: WeatherState?
    @NSManaged public var forecasts: NSSet?
    @NSManaged public var location: WeatherLocation?

}

// MARK: Generated accessors for forecasts
extension Weather {

    @objc(addForecastsObject:)
    @NSManaged public func addToForecasts(_ value: WeatherForecast)

    @objc(removeForecastsObject:)
    @NSManaged public func removeFromForecasts(_ value: WeatherForecast)

    @objc(addForecasts:)
    @NSManaged public func addToForecasts(_ values: NSSet)

    @objc(removeForecasts:)
    @NSManaged public func removeFromForecasts(_ values: NSSet)

}
