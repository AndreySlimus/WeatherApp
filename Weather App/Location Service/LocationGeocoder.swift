//
//  LocationGeocoder.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/11/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation
import CoreLocation

class LocationGeocoder {
    
    // MARK: - Constants
    private struct Constants {
        static let errorGeodecoding = "Не удалось определить местоположение."
    }
    
    // MARK: - Private Properties
    // MARK: -- Model Properties
    private let geocoder = CLGeocoder()
    
    // MARK: - Public Methods
    func decodeLocation(_ location: CLLocation,
                        completionHandler: @escaping(String) -> Void) {
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                completionHandler(Constants.errorGeodecoding)
                return
            }
            
            if let city = placemark.locality {
                completionHandler(city)
                return
            } else if let street = placemark.name {
                completionHandler(street)
                return
            } else if let area = placemark.administrativeArea {
                completionHandler(area)
                return
            } else if let thoroughfare = placemark.thoroughfare {
                completionHandler(thoroughfare)
                return
            } else if let country = placemark.country {
                completionHandler(country)
                return
            } else {
                completionHandler(Constants.errorGeodecoding)
                return
            }
        }
    }
    
}
