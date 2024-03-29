//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit
struct WeatherAPIClient {
    
    static let manager = WeatherAPIClient()
    
    func getWeather(lat: Double, long: Double, completionHandler: @escaping (Result<[DailyDatum], AppError>) -> () ) {
        var weatherURL: URL {
            guard let url = URL(string: "https://api.darksky.net/forecast/\(Secret.key)/\(lat),\(long)") else {fatalError("Error: Invalid URL")}
            return url
        }
        
        NetworkManager.manager.performDataTask(withUrl: weatherURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let weather = try Weather.getWeather(from: data)
                    guard let weatherUnwrapped = weather else {completionHandler(.failure(.invalidJSONResponse));return
                    }
                    completionHandler(.success(weatherUnwrapped))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    
    
    private init() {}
    
}
