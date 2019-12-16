//
//  CoreDataManager.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/6/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    // MARK: - Static Properties
    // MARK: -- Public
    static let shared = CoreDataManager()
    
    // MARK: - Public Properties
    // MARK: -- Model Properties
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherApp")
        
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        
        let context = self.persistentContainer.viewContext
        
        return context
    }()
    
    var privateQueueConcurrencyContext: NSManagedObjectContext {
        
        let privateQueueConcurrencyContext = NSManagedObjectContext.init(concurrencyType: .privateQueueConcurrencyType)
        privateQueueConcurrencyContext.parent = self.context
        
        return privateQueueConcurrencyContext
    }
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    private init() { }
    
    // MARK: - Public Methods
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("""
                    Method: CoreDataManager.saveContext
                    \nError: \(nserror.localizedDescription)
                    """)
            }
        }
    }
    
}
