//
//  PhotoAPIManager.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoAPIClient {
    
    static let manager = PhotoAPIClient()
    
    func getPhotos(city: String, completionHandler: @escaping (Result<[Photo], AppError>) -> () ) {
        var photoURL: URL {
            guard let url = URL(string: "https://pixabay.com/api/?key=\(Secret.photoKey)&q=\(city)") else {fatalError("Bad image URL")}
            return url
        }
        
        NetworkManager.manager.performDataTask(withUrl: photoURL, httpMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                
//                let weather = try Weather.getWeather(from: data)
//                                   guard let weatherUnwrapped = weather else {completionHandler(.failure(.invalidJSONResponse));return
//                                   }
//                                   completionHandler(.success(weatherUnwrapped))
                
                do {
                    let photos = try Photo.getPhotosFromData(from: data)
                    guard let photosUnwrapped = photos else {completionHandler(.failure(.invalidJSONResponse)); return}
                    completionHandler(.success(photosUnwrapped))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
    
    
    private init() {}
    
}
