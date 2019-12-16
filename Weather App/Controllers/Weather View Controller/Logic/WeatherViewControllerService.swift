//
//  WeatherViewControllerService.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/3/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

protocol WeatherViewControllerServiceDelegate: class {
    
    func weatherService(_ service: WeatherViewControllerService,
                        didUpdateWeather weather: Weather)
    
}

class WeatherViewControllerService {
    
    // MARK: - Delegate
    weak var delegate: WeatherViewControllerServiceDelegate?
    
    // MARK: - Private Properties
    private let network = Network()
    private let locationManager = LocationManager()
    private var userLocation: UserLocation? {
        didSet {
            if let userLocation = self.userLocation {
                requestWeatherAtUserLocation(userLocation)
            }
        }
    }
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init () {
        
        self.locationManager.delegate = self
    }
    
    // MARK: - Public Methods
    func getLatestWeather(completionHandler: @escaping (Weather?) -> Void) {
        
        CoreDataWeatherManager.loadLatestWeather { weather in
            completionHandler(weather)
        }
    }
    
    // MARK: - Private Methods
    func requestWeatherAtUserLocation(_ location: UserLocation) {
        
        guard
            let latitude = location.location?.coordinate.latitude,
            let longitude = location.location?.coordinate.longitude
            else {
                return
        }
        
        self.network.getWeatherDataAt(latitude: latitude,
                                      longitude: longitude,
                                      completionHandler: { networkResponse in
                                        
                                        if let data = try? networkResponse.resolve() {
                                            
                                            CoreDataWeatherManager.saveWeather(from: data,
                                                                               atLocation: location,
                                                                               completionHandler: { [weak self] weather in
                                                                                
                                                                                guard
                                                                                    let self = self,
                                                                                    let weather = weather
                                                                                    else {
                                                                                        return
                                                                                }
                                                                            
                                                                                DispatchQueue.main.async {
                                                                                    self.delegate?.weatherService(self,
                                                                                                                  didUpdateWeather: weather)
                                                                                }
                                            })
                                        }
        })
    }
    
}

// MARK: - Delegate: LocationManagerDelegate
extension WeatherViewControllerService: LocationManagerDelegate {
    
    func locationManager(_ locationManager: LocationManager,
                         didUpdateUserLocation userLocation: UserLocation) {
        
        self.userLocation = userLocation
    }
    
}
