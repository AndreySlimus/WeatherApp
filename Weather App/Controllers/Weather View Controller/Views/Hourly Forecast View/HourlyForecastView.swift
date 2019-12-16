//
//  HourlyForecastView.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/5/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class HourlyForecastView: UIView, UICollectionViewDelegate {
    
    // MARK: - Class Methods
    class func instanceFromNib() -> HourlyForecastView? {
        
        let nib = UINib(nibName: "HourlyForecastView", bundle: nil)
        
        guard
            let view = nib.instantiate(withOwner: nil,
                                       options: nil).first as? HourlyForecastView
            else {
                return nil
        }
        
        return view
    }
    
    // MARK: -- Collection View ViewModels
    private var hourForecastViewModels: [HourForecastViewModel]?
    
    // MARK: - Private Properties
    // MARK: -- Outlets
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var dayTemperatureLabel: UILabel?
    @IBOutlet private weak var nightTemperatureLabel: UILabel?
    @IBOutlet private weak var forecastCollectionView: UICollectionView?
    
    // MARK: - Lifecycle
    // MARK: -- View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        
        self.dateLabel?.text = nil
        self.dayTemperatureLabel?.text = nil
        self.nightTemperatureLabel?.text = nil
        
        settingsForecastCollectionView()
    }
    
    // MARK: - Public Methods
    // MARK: -- Configure UI
    

    
    func changeAlpha(isHide: Bool) {
        
        if isHide {
            if
                let dateAlpha = self.dateLabel?.alpha,
                let dayTemperatureLabelAlpha = self.dayTemperatureLabel?.alpha,
                let nightTemperatureLabelAlpha = self.nightTemperatureLabel?.alpha,
                dateAlpha >= 0 {

                    self.dateLabel?.alpha = dateAlpha - 0.05
                    self.dayTemperatureLabel?.alpha = dayTemperatureLabelAlpha - 0.05
                    self.nightTemperatureLabel?.alpha = nightTemperatureLabelAlpha - 0.05
            }
            
        } else if !isHide {
            if
                let dateAlpha = self.dateLabel?.alpha,
                let dayTemperatureLabelAlpha = self.dayTemperatureLabel?.alpha,
                let nightTemperatureLabelAlpha = self.nightTemperatureLabel?.alpha,
                alpha <= 1.0 {
                
                self.dateLabel?.alpha = dateAlpha + 0.05
                self.dayTemperatureLabel?.alpha = dayTemperatureLabelAlpha + 0.05
                self.nightTemperatureLabel?.alpha = nightTemperatureLabelAlpha + 0.05
            }
        }
    }
    
    func cancelAlphaEffect() {
        
        self.dateLabel?.alpha = 1.0
        self.dayTemperatureLabel?.alpha = 1.0
        self.nightTemperatureLabel?.alpha = 1.0
    }
    
    func configure(with viewModel: HourlyForecastViewModel) {
        
        self.dateLabel?.text = viewModel.title
        self.dayTemperatureLabel?.text = viewModel.dayTemperature
        self.nightTemperatureLabel?.text = viewModel.nightTemperature
        self.hourForecastViewModels = viewModel.hourlyForecasts
        
        self.forecastCollectionView?.reloadData()
    }
    
    // MARK: - Private Methods
    // MARK: -- Settings UI
    private func settingsForecastCollectionView() {
        
        self.forecastCollectionView?.dataSource = self
        self.forecastCollectionView?.delegate = self
        
        self.forecastCollectionView?.register(UINib.init(nibName: HourForecastCell.nibName,
                                                         bundle: nil),
                                              forCellWithReuseIdentifier: HourForecastCell.reuseIdentifier)
    }

}

extension HourlyForecastView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return hourForecastViewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = self.forecastCollectionView?.dequeueReusableCell(withReuseIdentifier: HourForecastCell.reuseIdentifier,
                                                                        for: indexPath) as? HourForecastCell,
            let viewModel = self.hourForecastViewModels?[indexPath.row]
            else {
                return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel)
        
        return cell
    }

}

extension HourlyForecastView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let viewModel = self.hourForecastViewModels?[indexPath.row] else {
            return CGSize()
        }

        return CGSize(width: viewModel.cellWidth ?? HourForecastCell.standaresWidth,
                      height: HourForecastCell.standaresHeight)
    }
    
}
