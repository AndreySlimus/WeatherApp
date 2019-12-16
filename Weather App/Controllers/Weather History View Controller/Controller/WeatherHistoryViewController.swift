//
//  WeatherHistoryViewController.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/10/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit
import CoreData

class WeatherHistoryViewController: UIViewController {

    // MARK: - Private Properties
    // MARK: -- Model Properties
    private var cellPresenter = WeatherHistoryCellPresenter()
    
    private var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? {
        
        if _fetchedResultsController != nil {
            return _fetchedResultsController
        }
        
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        
        fetchRequest.fetchBatchSize = 15
        
        let sortDescriptor = NSSortDescriptor(key: "unixtime", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: CoreDataManager.shared.context,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        
        aFetchedResultsController.delegate = self
        
        _fetchedResultsController = aFetchedResultsController as? NSFetchedResultsController<NSFetchRequestResult>
        
        do {
            try _fetchedResultsController?.performFetch()
        } catch {
            let nserror = error as NSError
            print("Method: WeatherForecastsHistoryViewController.fetchedResultsController \nError: \(nserror.localizedDescription)")
        }
        
        return _fetchedResultsController
    }
    
     // MARK: -- Outlets
    @IBOutlet private weak var tableView: UITableView?
    
    // MARK: - Lifecycle
    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsNavigationBar()
        settingsTableView()
    }
    
    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settingsTableView() {
        
        tableView?.dataSource = self
        tableView?.separatorColor = .white
        
        tableView?.register(UINib.init(nibName: WeatherHistoryCell.nibName,
                                       bundle: nil),
                            forCellReuseIdentifier: WeatherHistoryCell.reuseIdentifier)
    }
    
    private func settingsNavigationBar() {
        
        self.navigationItem.title = "История прогнозов"
    }
    
    // MARK: -- Configure UI
    func configureCell(_ cell: WeatherHistoryCell,
                       withWeather weather: Weather) {
        
        guard let viewModel = cellPresenter.createViewModel(from: weather) else { return }
        
        cell.configure(viewModel)
    }
    
}

// MARK: - Delegate: UITableViewDataSource
extension WeatherHistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.fetchedResultsController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let weather = self.fetchedResultsController?.object(at: indexPath) as? Weather,
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherHistoryCell.reuseIdentifier,
                                                     for: indexPath) as? WeatherHistoryCell
            else {
                return UITableViewCell()
        }
        
        configureCell(cell, withWeather:weather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return WeatherHistoryCell.standardHeight
    }
    
}

// MARK: - Delegate: NSFetchedResultsController
extension WeatherHistoryViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView?.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView?.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView?.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard
                let newIndexPath = newIndexPath,
                let tableView = self.tableView
                else {
                    return
            }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard
                let indexPath = indexPath,
                let tableView = self.tableView
                else {
                    return
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .update:
            guard
                let indexPath = indexPath,
                let tableView = self.tableView,
                let cell = tableView.cellForRow(at: indexPath) as? WeatherHistoryCell,
                let weather = anObject as? Weather
                else {
                    return
            }
            configureCell(cell, withWeather: weather)
        case .move:
            guard
                let indexPath = indexPath,
                let tableView = self.tableView,
                let cell = tableView.cellForRow(at: indexPath) as? WeatherHistoryCell,
                let weather = anObject as? Weather,
                let newIndexPath = newIndexPath
                else {
                    return
            }
            configureCell(cell, withWeather: weather)
            tableView.moveRow(at: indexPath, to: newIndexPath)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView?.endUpdates()
    }
    
}
