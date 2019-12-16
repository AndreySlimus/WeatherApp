//
//  WeatherPropertiesTableView.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/10/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherPropertiesTableView: UITableView {
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        settings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        settings()
    }
    
    func setupFooterView() {
        
        self.backgroundColor = .clear
        self.tableFooterView = UIView()
    }
    
    // MARK: - Private Methods
    // MARK: -- Settings UI
    fileprivate func settings() {
        
        self.register(UINib.init(nibName: WeatherPropertyCell.nibName,
                                 bundle: nil),
                      forCellReuseIdentifier: WeatherPropertyCell.reuseIdentifier)
        
        self.isScrollEnabled = false
        self.separatorColor = .purple
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
