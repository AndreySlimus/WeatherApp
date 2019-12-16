//
//  LocationManager.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/11/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    
    func locationManager(_ locationManager: LocationManager,
                         didUpdateUserLocation userLocation: UserLocation)
    
}

class LocationManager: NSObject {
    
    // MARK: - Delegate
    weak var delegate: LocationManagerDelegate?
    
    // MARK: - Private Properties
    // MARK: -- Model Properties
    let locationManager =  CLLocationManager()
    let locationGeocoder = LocationGeocoder()
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required override init() {
        super.init()
        
        settings()
        requestLocation()
    }
    
    // MARK: - Public Methods
    func requestLocation() {
        self.locationManager.requestLocation()
    }
    
    // MARK: - Private Methods
    private func settings() {
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    private func createUserLocation(_ location: CLLocation) {
       
        locationGeocoder.decodeLocation(location) { [weak self] locationDescription in
            
            guard let self = self else { return }
            
            let userLocation = UserLocation.init(description: locationDescription,
                                                 location: location)
            
            self.delegate?.locationManager(self, didUpdateUserLocation: userLocation)
        }
    }
    
}

// MARK: - Extensions CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            createUserLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed to find user's location: \(error.localizedDescription)")
    }
    
}
