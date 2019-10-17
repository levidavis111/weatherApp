//
//  Photo.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable {

    let hits: [Photo]
    
}

struct Photo: Codable {
    let user: String
    let webformatURL: String
    let previewURL: String

    
    static func getPhotosFromData(from jsonData: Data) throws -> [Photo]? {
        let response = try JSONDecoder().decode(PhotoWrapper.self, from: jsonData)
        return response.hits
    }

}
