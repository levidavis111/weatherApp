//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    
    func testWeatherModelFromJSON() {
        guard let path = Bundle.main.path(forResource: "Weather", ofType: "json") else {XCTFail(); return}
        let urlFromFile = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: urlFromFile)
            guard let weatherData = try Weather.getWeather(from: data) else {XCTFail(); return}
            print(weatherData.count)
            XCTAssert(weatherData.count > 0)
            
        } catch {
            XCTFail()
            print(error)
        }
        
    }
    
    func testPhotoModelFromJSON() {
        guard let path = Bundle.main.path(forResource: "Photo", ofType: "json") else {XCTFail(); return}
        let urlFromFile = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: urlFromFile)
            guard let photoData = try Photo.getPhotosFromData(from: data) else {XCTFail(); return}
            print(photoData.count)
            XCTAssert(photoData.count > 0)
        } catch {
            XCTFail()
            print(error)
        }
        
        
    }


}
