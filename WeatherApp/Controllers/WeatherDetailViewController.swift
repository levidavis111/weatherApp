//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/10/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    //MARK: - Local variables
    
    var oneWeather: DailyDatum!
    
    var cityName: String!
    
    //MARK: - Outlets

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    //MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private functions

    private func setupView() {
        let image = oneWeather.returnPictureBasedOnIcon(icon: oneWeather.icon)
        let fortmattedPrecipitation = String(format: "%.0f", (oneWeather.precipProbability * 100))
        let rawSunrise = oneWeather.getDateFromTime(time: oneWeather.sunriseTime).components(separatedBy: " ")
        let sunrise = "\(rawSunrise[4]) \(rawSunrise[5]) EDT"
        let rawSunset = oneWeather.getDateFromTime(time: oneWeather.sunsetTime).components(separatedBy: " ")
        let sunset = "\(rawSunset[4]) \(rawSunset[5]) EDT"
        
        detailImageView.image = image
        locationLabel.text = "Forcast for: \(cityName ?? "")"
        forecastLabel.text = oneWeather.summary
        highTempLabel.text = "High: \(oneWeather.temperatureHigh)"
        lowTempLabel.text = "Low: \(oneWeather.temperatureLow)"
        sunriseLabel.text = "Sunrise: \(sunrise)"
        sunsetLabel.text = "Sunset: \(sunset)"
        windSpeedLabel.text = "Wind Speed \(oneWeather.windsSpeed ?? 0) mph"
        precipitationLabel.text = "\(fortmattedPrecipitation)% chance of rain"
        
    }

}
