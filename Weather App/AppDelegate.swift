//
//  AppDelegate.swift
//  Weather App
//
//  Created by Andrey Malaev on 11/29/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit
import  CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let weatherCoordinator = WeatherCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let startPageViewController = weatherCoordinator.startPageViewController {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = startPageViewController
            self.window?.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }

}
