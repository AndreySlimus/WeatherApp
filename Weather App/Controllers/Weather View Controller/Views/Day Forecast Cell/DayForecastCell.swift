//
//  DayForecastCell.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class DayForecastCell: UITableViewCell {
    
    // MARK: - Static Properties
    // MARK: -- Public
    static let nibName = "DayForecastCell"
    static let reuseIdentifier = "DayForecastCell"
    static let standardHeight: CGFloat = 40
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var dayLabel: UILabel?
    @IBOutlet private weak var pictureImageView: UIImageView?
    @IBOutlet private weak var dayTemperatureLabel: UILabel?
    @IBOutlet private weak var nightTemperatureLabel: UILabel?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.dayLabel?.text = nil
        self.pictureImageView?.image = nil
        self.dayTemperatureLabel?.text = nil
        self.nightTemperatureLabel?.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.dayLabel?.text = nil
        self.pictureImageView?.image = nil
        self.dayTemperatureLabel?.text = nil
        self.nightTemperatureLabel?.text = nil
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(with viewModel: DayForecastCellViewModel) {
        
        self.dayLabel?.text = viewModel.day
        self.pictureImageView?.image = viewModel.picture
        self.dayTemperatureLabel?.text = viewModel.dayTemperature
        self.nightTemperatureLabel?.text = viewModel.nightTemperature
    }
    
}
