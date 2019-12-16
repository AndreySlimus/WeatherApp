//
//  WeatherPropertyCell.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherPropertyCell: UITableViewCell {
    
    // MARK: - Static Properties
    // MARK: -- Public
    static let nibName = "WeatherPropertyCell"
    static let reuseIdentifier = "WeatherPropertyCell"
    static let standardHeight: CGFloat = 70
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var parameterLabel: UILabel?
    @IBOutlet private weak var valueLabel: UILabel?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        self.parameterLabel?.text = nil
        self.valueLabel?.text = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.parameterLabel?.text = nil
        self.valueLabel?.text = nil
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(with viewModel: WeatherPropertyCellViewModel) {
        
        self.parameterLabel?.text = viewModel.parameter
        self.valueLabel?.text = viewModel.value
    }
    
    func deleteSeparator() {
        
        self.separatorInset = UIEdgeInsets(top: 0,
                                           left: self.bounds.size.width,
                                           bottom: 0,
                                           right: 0)
    }
    
}
