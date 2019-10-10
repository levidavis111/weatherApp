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
    @IBOutlet weak var forecastLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    

    private func setupView() {
        detailImageView.image = UIImage(named: oneWeather.icon)
        forecastLabel.text = oneWeather.summary
    }

}
