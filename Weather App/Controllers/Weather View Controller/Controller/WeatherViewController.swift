//
//  ViewController.swift
//  Weather App
//
//  Created by Andrey Malaev on 11/29/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Private Properties
    // MARK: -- Model Properties
    private let service = WeatherViewControllerService()
    private let presenter = WeatherViewControllerPresenter()
    private var viewModel: WeatherViewControllerViewModel? {
        didSet {
            guard let viewModel = self.viewModel else { return }
            configure(with: viewModel)
        }
    }
    private var weather: Weather? {
        didSet {
            guard let weather = self.weather else { return }
            let viewModel = presenter.createViewModel(from: weather)
            self.viewModel = viewModel
        }
    }
    
    // MARK: -- Outlets
    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private weak var scrollViewContentView: UIView?
    @IBOutlet private weak var headerConteinerView: UIView?
    @IBOutlet private weak var hourlyForecastContainerView: UIView?
    @IBOutlet private weak var dailyForecastContainerView: UIView?
    @IBOutlet private weak var descriptionContainerView: UIView?
    @IBOutlet private weak var propertiesContainerView: UIView?
    
    // MARK: -- UI Properties
    private let headerView = WeatherHeaderView.instanceFromNib()
    private let hourlyForecastView = HourlyForecastView.instanceFromNib()
    private var descriptionView = WeatherDescriptionView.instanceFromNib()
    private var dailyForecastTableView = DailyForecastTableView.init(frame: CGRect.zero,
                                                                     style: .plain)
    private var propertiesTableView = WeatherPropertiesTableView.init(frame: CGRect.zero,
                                                                      style: .plain)
    
    var scrollViewContentOffset: CGFloat = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderView()
        setupHourlyForecastView()
        setupDailyForecastTableView()
        setupDescriptionView()
        setupPropertiesTableView()
        
        settingsScrollView()
        settingsDailyForecastTableView()
        settingsPropertiesTableView()
        
        settingsService()
        
        getLatestWeather()
    }

    // MARK: - Private Methods
    // MARK: -- Setup UI
    private func setupHeaderView() {
        
        if let headerView = self.headerView {
            self.headerConteinerView?.addContainerSubview(headerView)
        }
    }
    
    private func setupHourlyForecastView() {
        
        if let hourlyForecastView = self.hourlyForecastView {
            self.hourlyForecastContainerView?.addContainerSubview(hourlyForecastView)
        }
    }
    
    private func setupDailyForecastTableView() {
        
        self.dailyForecastContainerView?.addContainerSubview(self.dailyForecastTableView)
    }
    
    private func setupDescriptionView() {
        
        if let descriptionView = self.descriptionView {
            self.descriptionContainerView?.addContainerSubview(descriptionView)
        }
    }
    
    private func setupPropertiesTableView() {
        
        self.propertiesContainerView?.addContainerSubview(self.propertiesTableView)
    }
    
     // MARK: -- Settings UI
    private func settingsScrollView() {
        
        self.scrollView?.delegate = self
    }
    
    private func settingsDailyForecastTableView() {
        
        self.dailyForecastTableView.setupFooterView()
        self.dailyForecastTableView.dataSource = self
    }
    
    private func settingsPropertiesTableView() {
        
        self.propertiesTableView.setupFooterView()
        self.propertiesTableView.separatorColor = .white
        self.propertiesTableView.dataSource = self
    }
    
    // MARK: -- Configure UI
    private func configure(with viewModel: WeatherViewControllerViewModel) {
        
        if let headerViewModel = viewModel.headerViewModel {
            self.headerView?.configure(with: headerViewModel)
        }
        
        if let hourlyForecastViewModel = viewModel.hourlyForecastViewModel {
            self.hourlyForecastView?.configure(with: hourlyForecastViewModel)
        }
        
        if viewModel.dailyForecastViewModel != nil {
            self.dailyForecastTableView.reloadData()
        }
        
        if let descriptionViewModel = viewModel.descriptionViewModel {
            self.descriptionView?.configure(with: descriptionViewModel)
        }
        
        if viewModel.propertiesViewModel != nil {
            self.propertiesTableView.reloadData()
        }
    }
    
    // MARK: -- Other
    private func settingsService() {
        
        self.service.delegate = self
    }
    
    private func getLatestWeather() {
        
        self.service.getLatestWeather { weather in
            
            self.weather = weather
        }
    }
    
}

// MARK: - Delegate: UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case is DailyForecastTableView:
            return viewModel?.dailyForecastViewModel?.viewModels?.count ?? 0
        case is WeatherPropertiesTableView:
            return viewModel?.propertiesViewModel?.viewModels?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case is DailyForecastTableView:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: DayForecastCell.reuseIdentifier,
                                                         for: indexPath) as? DayForecastCell,
                let viewModel = self.viewModel?.dailyForecastViewModel?.viewModels?[indexPath.row]
                else {
                    return UITableViewCell()
            }
            
            cell.configure(with: viewModel)
            
            return cell
            
        case is WeatherPropertiesTableView:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: WeatherPropertyCell.reuseIdentifier,
                                                         for: indexPath) as? WeatherPropertyCell,
                let viewModel = self.viewModel?.propertiesViewModel?.viewModels?[indexPath.row]
                else {
                    return UITableViewCell()
            }
            
            if let count = self.viewModel?.propertiesViewModel?.viewModels?.count {
                
                if (indexPath.row == count - 1) {
                    cell.deleteSeparator()
                }
            }
            
            cell.configure(with: viewModel)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch tableView {
        case is DailyForecastTableView:
            return DayForecastCell.standardHeight
        case is WeatherPropertiesTableView:
            return WeatherPropertyCell.standardHeight
        default:
            return 0
        }
    }
    
}

// MARK: - Delegate: WeatherViewControllerServiceDelegate
extension WeatherViewController: WeatherViewControllerServiceDelegate {
    
    func weatherService(_ service: WeatherViewControllerService,
                        didUpdateWeather weather: Weather) {
        
        self.weather = weather
    }
}

extension WeatherViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 10 {
            
            headerView?.changeAlpha(isHide: true)
            hourlyForecastView?.changeAlpha(isHide: true)
            
        } else if scrollView.contentOffset.y < 10 && scrollView.contentOffset.y < self.scrollViewContentOffset {
            
            headerView?.changeAlpha(isHide: false)
            hourlyForecastView?.changeAlpha(isHide: false)
            
        } else if scrollView.contentOffset.y < 0 {
            
            self.headerView?.cancelAlphaEffect()
            self.hourlyForecastView?.cancelAlphaEffect()
        }
        
        self.scrollViewContentOffset = scrollView.contentOffset.y
    }
    
}
