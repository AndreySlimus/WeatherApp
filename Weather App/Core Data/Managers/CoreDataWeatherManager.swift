//
//  CoreDataWeatherManager.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/13/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

class CoreDataWeatherManager {
    
    // MARK: - Static Methods
    // MARK: -- Public
    static func loadLatestWeather(completionHandler: @escaping (Weather?) -> Void) {
        
        let context = CoreDataManager.shared.privateQueueConcurrencyContext
        
        context.perform {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Weather")
            
            fetchRequest.fetchLimit = 1
            
            let sortDescription = NSSortDescriptor.init(key: "unixtime", ascending: false)
            fetchRequest.sortDescriptors = [sortDescription]
            
            do {
                
                let weatherResponse = try CoreDataManager.shared.context.fetch(fetchRequest) as? [Weather]
                
                if let weather = weatherResponse?.first {
                    DispatchQueue.main.async {
                        completionHandler(weather)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(nil)
                    }
                }
                
            } catch {
                
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
    
    static func saveWeather(from data: Data,
                            atLocation userLocation: UserLocation,
                            completionHandler: @escaping (Weather?) -> Void) {
        
        let context = CoreDataManager.shared.privateQueueConcurrencyContext
        
        context.perform {
            
            do {
                
                guard let codingUserInfoContext = CodingUserInfoKey.context else { return }
                
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoContext] = context
                
                let weather = try decoder.decode(Weather.self, from: data)
                
                // create weather location entity
                if let weatherLocation =  NSEntityDescription.insertNewObject(forEntityName: "WeatherLocation",
                                                                              into: context) as? WeatherLocation {
                    
                    weatherLocation.location = userLocation.description
                    
                    if
                        let userLocationLatitudeValue = userLocation.location?.coordinate.latitude,
                        let userLocationLongitudeValue = userLocation.location?.coordinate.longitude {
                        
                        weatherLocation.latitude = userLocationLatitudeValue
                        weatherLocation.longitude = userLocationLongitudeValue
                    }
                    
                    weatherLocation.weather = weather
                }
                
                try context.save()
                
                completionHandler(weather)
                
            } catch let error as NSError {
                
                print(
                    """
                    Method: saveWeather(from data: Data,
                    atLocation userLocation: UserLocation)
                    \nError: \(error.localizedDescription)
                    """)
            }
            
            CoreDataManager.shared.saveContext()
        }
    }
    
}
