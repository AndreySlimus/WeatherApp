//
//  WeatherHistoryCellViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherHistoryCellViewModel {
    
    // MARK: - Private Properties
    private(set) var date: String?
    private(set) var location: String?
    private(set) var currentTemperature: String?
    private(set) var dayTemperature: String?
    private(set) var nightTemperature: String?
    private(set) var picture: UIImage?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(date: String?,
                  location: String?,
                  currentTemperature: String?,
                  dayTemperature: String?,
                  nightTemperature: String?,
                  picture: UIImage?) {
        
        self.date = date
        self.location = location?.capitalized
        self.currentTemperature = currentTemperature
        self.dayTemperature = dayTemperature
        self.nightTemperature = nightTemperature
        self.picture = picture
    }
    
}
