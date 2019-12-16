//
//  DailyForecastTableView.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class DailyForecastTableView: UITableView {
    
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
    
    // MARK: - Public Methods
    func setupFooterView() {
        
        self.backgroundColor = .clear
        self.tableFooterView = UIView()
    }
 
    // MARK: - Private Methods
    // MARK: -- Settings UI
    fileprivate func settings() {
        
        self.register(UINib.init(nibName: DayForecastCell.nibName,
                                 bundle: nil),
                      forCellReuseIdentifier: DayForecastCell.reuseIdentifier)
        
        self.isScrollEnabled = false
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.backgroundColor = .clear
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
