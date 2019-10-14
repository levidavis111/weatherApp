//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/10/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var oneWeather: DailyDatum!
    
    var cityName: String!

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    

    private func setupView() {
        let image = oneWeather.returnPictureBasedOnIcon(icon: oneWeather.icon)
        let fortmattedPrecipitation = String(format: "%.2f", (oneWeather.precipProbability * 100))
//        let doubleStr = String(format: "%.2f", myDouble) // "3.14"
        detailImageView.image = image
        locationLabel.text = "Forcast for: \(cityName ?? "")"
        forecastLabel.text = oneWeather.summary
        highTempLabel.text = "High: \(oneWeather.temperatureHigh)"
        lowTempLabel.text = "Low: \(oneWeather.temperatureLow)"
        sunriseLabel.text = "Sunrise: \(oneWeather.getDateFromTime(time: oneWeather.sunriseTime).components(separatedBy: " ")[1])"
        sunsetLabel.text = "Sunset: \(oneWeather.getDateFromTime(time: oneWeather.sunsetTime).components(separatedBy: " ")[1])"
        windSpeedLabel.text = "Wind Speed \(oneWeather.windsSpeed ?? 0) mph"
        precipitationLabel.text = "\(fortmattedPrecipitation)% chance of rain"
        
    }

}
