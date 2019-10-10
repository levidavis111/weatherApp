//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weather: Weather? {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    let cellSpacing: CGFloat = 5.0
    
    @IBOutlet weak var cityForecastLabel: UILabel!
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        loadData()
    }
    
    private func setDelegates() {
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        textFieldOutlet.delegate = self
    }

    private func loadData() {
        WeatherAPIClient.manager.getWeather { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self.weather = weather
            }
        }
    }
    
    private func getCoordinates() {
        ZipCodeHelper.getLatLong(fromZipCode: "60613") { (result) in
            switch result {
            case let .success((lat, long)):
                print(lat, long)
            case let .failure(error):
                print(error)
            }
        }
    }

}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather?.daily.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        
        let oneDay = weather?.daily.data[indexPath.row]
        cell.iconImageView.image = UIImage(named: oneDay?.icon.replacingOccurrences(of: "-", with: "_") ?? "")
        cell.hiTempLabel.text = "High: \(oneDay?.temperatureHigh ?? 0)"
        cell.loTempLabel.text = "Low: \(oneDay?.temperatureLow ?? 0)"
        cell.dateLabel.text = "Date: \(Date())"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oneDay = weather?.daily.data[indexPath.row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let detailVC = storyBoard.instantiateViewController(withIdentifier: "detailVC") as? WeatherDetailViewController else {return}
        detailVC.oneWeather = oneDay
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 3
        let numSpaces: CGFloat = numCells + 1
        
        let screenWidth = UIScreen.main.bounds.width
        let screenheight = UIScreen.main.bounds.height
        
        return CGSize(width: (screenWidth - (cellSpacing * numSpaces)) / numCells, height: screenheight / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}


extension WeatherViewController: UICollectionViewDelegate {}

extension WeatherViewController: UITextFieldDelegate {}

