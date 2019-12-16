//
//  WeatherForecastParts+Decodable.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

extension WeatherForecastParts: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case day = "day_short"
        case night = "night_short"
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
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherForecastParts", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.day = try container.decodeIfPresent(WeatherForecastPart.self, forKey: .day)
        self.night = try container.decodeIfPresent(WeatherForecastPart.self, forKey: .night)
    }
    
}
