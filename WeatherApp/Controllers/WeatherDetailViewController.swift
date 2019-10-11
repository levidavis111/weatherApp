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
        detailImageView.image = UIImage(named: oneWeather.icon)
        forecastLabel.text = oneWeather.summary
        sunriseLabel.text = "Sunrise: \(oneWeather.getDateFromTime(time: oneWeather.sunriseTime).components(separatedBy: " ")[1])"
    }

}
