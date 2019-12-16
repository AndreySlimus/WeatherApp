//
//  WeatherForecastParts+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import Foundation
import CoreData

extension WeatherForecastParts {
    
    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecastParts> {
        return NSFetchRequest<WeatherForecastParts>(entityName: "WeatherForecastParts")
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var day: WeatherForecastPart?
    @NSManaged public var night: WeatherForecastPart?
    @NSManaged public var forecast: WeatherForecast?

}
