//
//  WeatherState+Decodable.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

extension WeatherState: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case precipitation = "prec_prob"
        case humidity
        case windSpeed = "wind_speed"
        case windDirection = "wind_dir"
        case feelsTemperature = "feels_like"
        case iconName = "icon"
        case pressure = "pressure_mm"
        case ultravioletIndex = "uv_index"
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
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherState", in: context) else {
            throw CoreDataInitializationErrors.noEntity
        }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.temperature = try container.decodeIfPresent(Int16.self, forKey: .temperature) ?? 1000
        self.precipitation = try container.decodeIfPresent(Double.self, forKey: .precipitation) ?? 0
        self.humidity = try container.decodeIfPresent(Int16.self, forKey: .humidity) ?? 0
        self.iconName = try container.decodeIfPresent(String.self, forKey: .iconName)
        self.pressure = try container.decodeIfPresent(Int16.self, forKey: .pressure) ?? 0
        self.ultravioletIndex = try container.decodeIfPresent(Int16.self, forKey: .ultravioletIndex) ?? 0
        self.feelsTemperature = try container.decodeIfPresent(Int16.self, forKey: .feelsTemperature) ?? 0
        self.windSpeed = try container.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0
        self.windDirection = try container.decodeIfPresent(String.self, forKey: .windDirection)
        self.condition = try container.decodeIfPresent(String.self, forKey: .condition)
    }
    
}
