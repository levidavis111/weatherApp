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

    
    func testModelFromJSON() {
        guard let path = Bundle.main.path(forResource: "Weather", ofType: "json") else {XCTFail(); return}
        let urlFromFile = URL(fileURLWithPath: path)
        do {
           let data = try Data(contentsOf: urlFromFile)
            guard let weatherData = try Weather.getWeather(from: data) else {return}
            print(weatherData.count)
            XCTAssert(weatherData.count > 0)

        } catch {
            XCTFail()
            print(error)
        }
       
    
    
}


}
