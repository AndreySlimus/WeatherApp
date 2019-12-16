//
//  DayForecastCellViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class DayForecastCellViewModel {
    
    // MARK: - Private Properties
    private(set) var day: String?
    private(set) var dayTemperature: String?
    private(set) var nightTemperature: String?
    private(set) var picture: UIImage?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(day: String?,
                  dayTemperature: String?,
                  nightTemperature: String?,
                  picture: UIImage?) {
        
        self.day = day
        self.dayTemperature = dayTemperature
        self.nightTemperature = nightTemperature
        self.picture = picture
    }
    
}
