//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/9/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Local variables
    
    var weather = [DailyDatum]() {
        didSet {
            weatherCollectionView.reloadData()
        }
    }
    
    var lat: Double?
    
    var long: Double?
    
    var cityName: String? {
        didSet{
            cityForecastLabel.text = "Forecast for \(self.cityName ?? "")"
        }
    }
    
    var textString: String?
    
    let cellSpacing: CGFloat = 5.0
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityForecastLabel: UILabel!
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    
    //MARK: = Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setDelegates()
        loadDefaults()
    }
    
    //MARK: - IBActions
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        
        let favoriteVC = FavoritesViewController()
        favoriteVC.cityName = self.cityName
        self.navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    //MARK: - Private funtions
    
    private func setBackgroundImage() {
        self.backgroundImageView.image = UIImage(named: "background")
    }
    
    private func setDelegates() {
           weatherCollectionView.delegate = self
           weatherCollectionView.dataSource = self
           textFieldOutlet.delegate = self
       }
    
    private func loadData() {
        guard let lat = lat,
            let long = long else {print("invalid zip"); return}
        WeatherAPIClient.manager.getWeather(lat: lat, long: long) { (result) in
            switch result {
            case .failure(let error):
                self.errorAlert()
                print(error)
            case .success(let weather):
                self.weather = weather
                self.weatherCollectionView.isHidden = false
            }
        }
    }
    
    private func getCoordinates(zipCode: String) {
        ZipCodeHelper.getLatLong(fromZipCode: zipCode) { (result) in
            switch result {
            case let .success((lat, long, name)):
                print(lat, long)
                self.cityName = name
                self.lat = lat
                self.long = long
                self.loadData()
            case let .failure(error):
                self.errorAlert()
                print(error)
            }
        }
    }
    
    private func errorAlert() {
        let alert = UIAlertController(title: nil, message: "Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadDefaults() {
        if let text = UserDefaults.standard.object(forKey: "searchText") {
            self.textFieldOutlet.text = text as? String
        } else {
            return
        }
    }
    
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = weatherCollectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else {return UICollectionViewCell()}
        
        let oneDay = weather[indexPath.row]
        let image = oneDay.returnPictureBasedOnIcon(icon: oneDay.icon)
        let rawDate = oneDay.getDateFromTime(time: oneDay.time).components(separatedBy: " ")
        let date = "\(rawDate[0]). \(rawDate[1]) ".replacingOccurrences(of: ",", with: "")

        cell.iconImageView.image = image
        cell.hiTempLabel.text = "High: \(oneDay.temperatureHigh)"
        cell.loTempLabel.text = "Low: \(oneDay.temperatureLow)"
        cell.dateLabel.text = "\(date)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oneDay = weather[indexPath.row]
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let detailVC = storyBoard.instantiateViewController(withIdentifier: "detailVC") as? WeatherDetailViewController else {return}
        detailVC.oneWeather = oneDay
        detailVC.cityName = self.cityName
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

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()  //if desired
        guard let text = textField.text else {errorAlert(); return false}
        guard text.count == 5 else { errorAlert(); return false}
        getCoordinates(zipCode: text)
        self.textString = text
        UserDefaults.standard.set(text, forKey: "searchText")
        return true
    }
}

