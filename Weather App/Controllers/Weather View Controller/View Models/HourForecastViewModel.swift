//
//  HourForecastViewModel.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class HourForecastViewModel {
    
    // MARK: - Private Properties
    private(set) var type: HourForecastCellType?
    private(set) var title: String?
    private(set) var precipitation: String?
    private(set) var temperature: String?
    private(set) var picture: UIImage?
    private(set) var cellWidth: CGFloat?
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    required init(type: HourForecastCellType?,
                  title: String?,
                  precipitation: String?,
                  temperature: String?,
                  picture: UIImage?,
                  cellWidth: CGFloat?) {
        
        self.type = type
        self.title = title
        self.precipitation = precipitation
        self.temperature = temperature
        self.picture = picture
        self.cellWidth = cellWidth
    }
    
}
