//
//  WeatherState+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/6/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import CoreData

extension WeatherState {
    
    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherState> {
        return NSFetchRequest<WeatherState>(entityName: "WeatherState")
    }
    
    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var feelsTemperature: Int16
    @NSManaged public var humidity: Int16
    @NSManaged public var iconName: String?
    @NSManaged public var precipitation: Double
    @NSManaged public var pressure: Int16
    @NSManaged public var temperature: Int16
    @NSManaged public var windDirection: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var ultravioletIndex: Int16
    @NSManaged public var condition: String?
    @NSManaged public var forecast: Weather?

}
