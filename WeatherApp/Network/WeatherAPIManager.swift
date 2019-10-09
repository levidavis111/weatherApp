//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
struct WeatherAPIClient {
    
    static let manager = WeatherAPIClient()
    
    func getWeather(completionHandler: @escaping (Result<Weather, AppError>) -> () ) {
        NetworkManager.manager.performDataTask(withUrl: weatherURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let weather = try Weather.getWeather(from: data)
                    completionHandler(.success(weather))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    func postWeather(weather: Weather, completionHandler: @escaping (Result<Data, AppError>) -> () ) {
        guard let encodedWeather = try? JSONEncoder().encode(weather) else {fatalError("postElementError")}
        NetworkManager.manager.performDataTask(withUrl: weatherURL, httpBody: encodedWeather, httpMethod: .post) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                completionHandler(.success(data))
            }
        }
    }
    
    
    private var weatherURL: URL {
        guard let url = URL(string: "https://api.darksky.net/forecast/\(Secret.key)/42.3601,-71.0589") else {fatalError("Error: Invalid URL")}
        return url
    }
    
    private init() {}
    
}
