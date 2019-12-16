//
//  WeatherDay+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import Foundation
import CoreData

extension WeatherForecastPart {

    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherForecastPart> {
        return NSFetchRequest<WeatherForecastPart>(entityName: "WeatherForecastPart")
    }
    
    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var temperature: Int16
    @NSManaged public var iconName: String?
    @NSManaged public var condition: String?
    @NSManaged public var day: WeatherForecastParts?
    @NSManaged public var night: WeatherForecastParts?

}
