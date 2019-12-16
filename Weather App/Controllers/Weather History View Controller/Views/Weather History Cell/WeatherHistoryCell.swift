//
//  WeatherHistoryCell.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/6/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherHistoryCell: UITableViewCell {
    
    // MARK: - Static Properties
    // MARK: -- Public
    static let nibName = "WeatherHistoryCell"
    static let reuseIdentifier = "WeatherHistoryCell"
    static let standardHeight: CGFloat = 130
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?
    @IBOutlet private weak var currentTemperatureLabel: UILabel?
    @IBOutlet private weak var dayTemperatureLabel: UILabel?
    @IBOutlet private weak var nightTemperatureLabel: UILabel?
    @IBOutlet private weak var pictureView: UIImageView?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.dateLabel?.text = nil
        self.locationLabel?.text = nil
        self.currentTemperatureLabel?.text = nil
        self.dayTemperatureLabel?.text = nil
        self.nightTemperatureLabel?.text = nil
        self.pictureView?.image = nil
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(_ viewModel: WeatherHistoryCellViewModel) {
        
        self.dateLabel?.text = viewModel.date
        self.locationLabel?.text = viewModel.location
        self.currentTemperatureLabel?.text = viewModel.currentTemperature
        self.dayTemperatureLabel?.text = viewModel.dayTemperature
        self.nightTemperatureLabel?.text = viewModel.nightTemperature
        self.pictureView?.image = viewModel.picture
    }
    
}
