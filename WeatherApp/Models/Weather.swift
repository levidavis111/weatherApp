//
//  Weather.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import UIKit

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
    let time: Int
    let summary: String
    let icon: String
    let sunriseTime, sunsetTime: Int
    let precipProbability: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureLow: Double
    let windsSpeed: Double?
   
    func getDateFromTime(time:Int) -> String {
           let date = NSDate(timeIntervalSince1970: Double(time))
        return date.description
       }
    
    func returnPictureBasedOnIcon(icon:String) -> UIImage {
        switch icon {
        case "rain":
            return UIImage(named: "rain")!
        case "cloudy":
            return UIImage(named: "cloudy")!
        case "partly-cloudy-night":
            return UIImage(named: "pcloudyn")!
        case "clear-day":
            return UIImage(named: "clear")!
        case "clear-night":
            return UIImage(named:"clearn")!
        case "partly-cloudy-day":
            return UIImage(named:"pcloudy" )!
        case "snow":
            return UIImage(named: "snow")!
        case "sleet":
            return UIImage(named: "sleet")!
        case "wind":
            return UIImage(named: "wind")!
        case "fog":
            return UIImage(named:"fog")!
        default:
            return UIImage(named: "image")!
        }
    }
}
