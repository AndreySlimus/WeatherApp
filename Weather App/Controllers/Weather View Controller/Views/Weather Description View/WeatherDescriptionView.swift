//
//  WeatherDescriptionView.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherDescriptionView: UIView {
    
    // MARK: - Class Methods
    class func instanceFromNib() -> WeatherDescriptionView? {
        
        let nib = UINib(nibName: "WeatherDescriptionView", bundle: nil)
        
        guard
            let view = nib.instantiate(withOwner: nil,
                                       options: nil).first as? WeatherDescriptionView
            else {
                return nil
        }
        
        view.layoutIfNeeded()
        
        return view
    }
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet weak var textLabel: UILabel?
    @IBOutlet weak var contentView: UIView?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView?.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textLabel?.text = nil
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    func configure(with viewModel: WeatherDescriptionViewModel) {
        
        self.textLabel?.text = viewModel.description
    }
    
}
