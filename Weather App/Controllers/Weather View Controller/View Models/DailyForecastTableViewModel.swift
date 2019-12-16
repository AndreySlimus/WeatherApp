//
//  DailyForecastTableViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class DailyForecastTableViewModel {
    
    // MARK: - Private Properties
    private(set) var viewModels: [DayForecastCellViewModel]?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(viewModels: [DayForecastCellViewModel]?) {
        
        self.viewModels = viewModels
    }
    
}
