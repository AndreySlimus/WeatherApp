//
//  WeatherHeaderView.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherHeaderView: UIView {
    
    // MARK: - Class Methods
    class func instanceFromNib() -> WeatherHeaderView? {
        
        let nib = UINib(nibName: "WeatherHeaderView", bundle: nil)
        
        guard
            let view = nib.instantiate(withOwner: nil,
                                       options: nil).first as? WeatherHeaderView
            else {
                return nil
        }
        
        return view
    }
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var locationLabel: UILabel?
    @IBOutlet private weak var conditionLabel: UILabel?
    @IBOutlet private weak var temperatureLabel: UILabel?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        
        self.locationLabel?.text = nil
        self.conditionLabel?.text = nil
        self.temperatureLabel?.text = nil
    }
    
    func changeAlpha(isHide: Bool) {
        
        if isHide, let alpha = self.temperatureLabel?.alpha, alpha > 0 {
            self.temperatureLabel?.alpha = alpha - 0.05
        } else if !isHide, let alpha = self.temperatureLabel?.alpha, alpha < 1.0 {
            self.temperatureLabel?.alpha = alpha + 0.05
        }
    }
    
    func cancelAlphaEffect() {
        
        self.temperatureLabel?.alpha = 1.0
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(with viewModel: WeatherHeaderViewModel) {
        
        self.locationLabel?.text = viewModel.location
        self.conditionLabel?.text = viewModel.condition
        self.temperatureLabel?.text = viewModel.temperature
    }
    
}
