//
//  WeatherCoordinator.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/12/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherCoordinator {
    
    // MARK: - Public Properties
    var startPageViewController: UIPageViewController? {
        
        if let viewControllers = self.weatherViewControllers {
            
            let pageController = WeatherPageViewController.init(viewControllers: viewControllers)
            
            return pageController
            
        } else {
            
            return nil
        }
    }
    
    // MARK: - Private Properties
    private var currentWeatherViewController: WeatherViewController? = {
        
        let storyboard = UIStoryboard.init(name: "WeatherViewController",
                                           bundle: nil)
        
        guard
            let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
            else {
                return nil
        }
        
        return viewController
    }()
    
    private var historyWeatherViewController: UINavigationController = {
       
        let storyboard = UIStoryboard.init(name: "WeatherHistoryViewController",
                                           bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherHistoryViewController")
        
        let navigationController = WeatherHistoryNavigationController.init(rootViewController: viewController)

        return navigationController
    }()
    
    private var weatherViewControllers: [UIViewController]? {
        
        if let currentWeatherViewController = self.currentWeatherViewController {
            
            let viewControllers = [
                currentWeatherViewController,
                historyWeatherViewController
            ]
            
            return viewControllers
            
        } else {
            
            return nil
        }
    }
    
}
