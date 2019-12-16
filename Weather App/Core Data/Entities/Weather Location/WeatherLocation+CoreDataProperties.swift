//
//  WeatherLocation+CoreDataProperties.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/7/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//
//

import Foundation
import CoreData

extension WeatherLocation {
    
    // MARK: - Class Methods
    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherLocation> {
        return NSFetchRequest<WeatherLocation>(entityName: "WeatherLocation")
    }
    
    // MARK: - Public Properties
    // MARK: -- Model Properties
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var weather: Weather?

}
