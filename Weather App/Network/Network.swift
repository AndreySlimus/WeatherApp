//
//  NetworkLayer.swift
//  Weather App
//
//  Created by Andrey Malaev on 12/2/19.
//  Copyright © 2019 Andrey Malaev. All rights reserved.
//

import Foundation

class Network {
    
    // MARK: - Constants
    private struct Constants {
        
        static let scheme = "https"
        static let host = "api.weather.yandex.ru"
        static let path = "/v1/forecast"
        static let latitudeQueryItemName = "lat"
        static let longitudeQueryItemName = "lon"
        static let languageQueryItemName = "lang"
        static let limitQueryItemName = "limit"
        static let hoursQueryItemName = "hours"
        static let standardLanguageValue = "ru_RU"
        static let standardLimitValue = 7
        static let standardHoursValue = true
        static let APIKey = "68e1b060-9507-4af0-92ae-7442950fede0"
        static let APIKeyHeader = "X-Yandex-API-Key"
    }

    // MARK: - Public Methods
    func getWeatherDataAt(latitude: Double,
                          longitude: Double,
                          completionHandler: @escaping DataLoadedCompletion) {
        
        guard let request = createRequest(latitude: latitude, longitude: longitude) else { return }
        
        URLSession.shared.dataTask(with: request) { data, _, error  in
            if let data = data {
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            } else if let error = error as NSError? {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    private func createRequest(latitude: Double, longitude: Double) -> URLRequest? {
        
        var components = URLComponents()
        
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = Constants.path
        
        components.queryItems = [
            URLQueryItem.init(name: Constants.latitudeQueryItemName, value: String(latitude)),
            URLQueryItem.init(name: Constants.longitudeQueryItemName, value: String(longitude)),
            URLQueryItem.init(name: Constants.languageQueryItemName, value: Constants.standardLanguageValue),
            URLQueryItem.init(name: Constants.limitQueryItemName, value: String(Constants.standardLimitValue)),
            URLQueryItem.init(name: Constants.hoursQueryItemName, value: String(Constants.standardHoursValue))
        ]
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest.init(url: url)
        
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(Constants.APIKey, forHTTPHeaderField: Constants.APIKeyHeader)
        
        return request
    }
    
}
