//
//  Weather.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let longitude: Double
    let latitude: Double
    let timezone: String
    let daily: Daily
    
    static func getWeather(from jsonData: Data) throws -> Weather? {
        let response = try JSONDecoder().decode(Weather.self, from: jsonData)
        return response
    }
    
}

//private enum CodingKeys: String, CodingKey {
//    case title
//    case firstName = "first"
//    case lastName = "last"
//}

struct Daily: Codable {
    let summary: String
    let icon: String
    let data: [DailyDatum]
}


struct DailyDatum: Codable {
    
    let summary: String
    let icon: String
    let sunriseTime, sunsetTime: Int
    let precipProbability: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureLow: Double
   
}
