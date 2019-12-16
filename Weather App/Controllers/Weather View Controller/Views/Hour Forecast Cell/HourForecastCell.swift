//
//  HourForecastCell.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class HourForecastCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    // MARK: -- Public
    static let nibName = "HourForecastCell"
    static let reuseIdentifier = "HourForecastCell"
    static let standaresWidth: CGFloat = 50
    static let standaresHeight: CGFloat = 130
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var temperatureLabel: UILabel?
    @IBOutlet private weak var precipitationLabel: UILabel?
    @IBOutlet private weak var pictureImageView: UIImageView?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.titleLabel?.text = nil
        self.temperatureLabel?.text = nil
        self.precipitationLabel?.text = nil
        self.pictureImageView?.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel?.text = nil
        self.temperatureLabel?.text = nil
        self.precipitationLabel?.text = nil
        self.pictureImageView?.image = nil
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(with viewModel: HourForecastViewModel) {
        
        self.titleLabel?.text = viewModel.title
        self.temperatureLabel?.text = viewModel.temperature
        self.precipitationLabel?.text = viewModel.precipitation
        self.pictureImageView?.image = viewModel.picture
    }
    
}
