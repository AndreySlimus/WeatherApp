//
//  WeatherForecastPart+Decodable.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

extension WeatherForecastPart: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case iconName = "icon"
        case condition
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
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherForecastPart", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temperature = try container.decodeIfPresent(Int16.self, forKey: .temperature) ?? 0
        self.iconName = try container.decodeIfPresent(String.self, forKey: .iconName)
        self.condition = try container.decodeIfPresent(String.self, forKey: .condition)
    }
    
}
