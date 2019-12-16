//
//  WeatherHistoryNavigationController.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/15/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherHistoryNavigationController: UINavigationController {
    
    // MARK: - Constants
    private struct Constants {
        
        static let foregroundColor = UIColor.white
        static let standardFontSize: CGFloat = 17
        static let largeFontSize: CGFloat = 34
        static let standardTitleFont = UIFont.systemFont(ofSize: standardFontSize, weight: .semibold)
        static let largeTitleFont = UIFont.systemFont(ofSize: largeFontSize, weight: .semibold)
        
        static let standardTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.foregroundColor,
            .font: Constants.standardTitleFont as Any
        ]
        
        static let largeTitleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Constants.foregroundColor,
            .font: Constants.largeTitleFont as Any
        ]
    }
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings()
    }
    
    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settings() {
        
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.titleTextAttributes = Constants.standardTitleTextAttributes
        self.navigationBar.largeTitleTextAttributes = Constants.largeTitleTextAttributes
        self.navigationBar.barTintColor = .weatherBackgroundColor
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = .white
    }
    
}
