//
//  WeatherForecast+Decodable.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

extension WeatherForecast: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case dateString = "date"
        case weatherForecast
        case parts
        case hours
        case unixtime = "date_ts"
    }
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    convenience public init(from decoder: Decoder) throws {
        
        guard
            let codingUserInfoContext = CodingUserInfoKey.context,
            let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext
            else {
                throw CoreDataInitializationErrors.noContext
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherForecast", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sunrise = try container.decodeIfPresent(String.self, forKey: .sunrise)
        self.sunset = try container.decodeIfPresent(String.self, forKey: .sunset)
        self.dateString = try container.decodeIfPresent(String.self, forKey: .dateString)
        self.parts = try container.decodeIfPresent(WeatherForecastParts.self, forKey: .parts)
        self.unixtime = try container.decode(Double.self, forKey: .unixtime)
        
        guard let hours = try container.decodeIfPresent(Set<WeatherForecastHour>.self,
                                                        forKey: .hours)
            else {
                return
        }
        
        self.addToHours(hours as NSSet)
    }
    
}
