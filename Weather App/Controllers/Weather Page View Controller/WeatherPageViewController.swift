//
//  WeatherPageViewController.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/12/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    
    // MARK: - Private Properties
    // MARK: -- UI Properties
    private var weatherViewControllers: [UIViewController]?
    private let pageControlBackgroundView = UIView()
    private let pageControlSeparatorView = UIView()
    
    // MARK: - Lifecycle
    // MARK: -- Initializations
    init(viewControllers: [UIViewController]) {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: [.interPageSpacing: 30])
        
        guard let firstViewController = viewControllers.first else { return }
        
        self.setViewControllers([firstViewController],
                                direction: .forward,
                                animated: true,
                                completion: nil)
        
        self.weatherViewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Lifecycle
    // MARK: -- ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings()
        
        setupPageControlBackgroundView()
        setupPageControlSeparatorView()
    }
    
    // MARK: - Private Methods
    // MARK: -- Setup UI
    private func setupPageControlBackgroundView() {
        
        self.pageControlBackgroundView.frame = CGRect.zero
        
        self.pageControlBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.pageControlBackgroundView.backgroundColor = .weatherBackgroundColor
        
        self.view.addSubview(self.pageControlBackgroundView)
        
        NSLayoutConstraint.activate([
            
            self.pageControlBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            self.pageControlBackgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.pageControlBackgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.pageControlBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setupPageControlSeparatorView() {
        
        self.pageControlSeparatorView.frame = CGRect.zero
        
        pageControlSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        pageControlSeparatorView.backgroundColor = .white
        
        self.pageControlBackgroundView.addSubview(self.pageControlSeparatorView)
        
        NSLayoutConstraint.activate([
            
            self.pageControlSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            self.pageControlSeparatorView.topAnchor.constraint(equalTo: self.pageControlBackgroundView.topAnchor),
            self.pageControlSeparatorView.leftAnchor.constraint(equalTo: self.pageControlBackgroundView.leftAnchor),
            self.pageControlSeparatorView.rightAnchor.constraint(equalTo: self.pageControlBackgroundView.rightAnchor)
        ])
    }

    // MARK: -- Settings UI
    private func settings() {
        
        self.dataSource = self
        
        self.view.backgroundColor = .weatherBackgroundColor
    }
    
}

// MARK: - Delegate: UIPageViewControllerDataSource
extension WeatherPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = self.weatherViewControllers?.index(of: viewController) else { return nil }
        
        if index > 0 {
            return weatherViewControllers?[index - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard
            let index = self.weatherViewControllers?.index(of: viewController),
            let count = weatherViewControllers?.count
            else {
                return nil
        }
        
        if index < count - 1 {
            return weatherViewControllers?[index + 1]
        } else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        if let count = self.weatherViewControllers?.count {
            return count
        } else {
            return 0
        }
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
}
