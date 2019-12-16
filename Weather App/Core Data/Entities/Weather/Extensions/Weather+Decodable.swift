//
//  Weather+Decodable.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

extension Weather: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case unixtime = "now"
        case dateString = "now_dt"
        case state = "fact"
        case forecasts
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
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Weather", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.unixtime = try container.decodeIfPresent(Double.self, forKey: .unixtime) ?? 0
        self.dateString = try container.decodeIfPresent(String.self, forKey: .dateString)
        self.state = try container.decodeIfPresent(WeatherState.self, forKey: .state)
        
        guard
            let forecasts = try container.decodeIfPresent(Set<WeatherForecast>.self,
                                                          forKey: .forecasts)
            else {
                return
        }
        
        self.addToForecasts(forecasts as NSSet)
    }
    
}
