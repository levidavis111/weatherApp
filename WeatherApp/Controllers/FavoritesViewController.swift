//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/10/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var photos = [Photo]() {
        didSet {
            favoritesView.collectionView.reloadData()
        }
    }
    
    var cityName: String!
    
    let cellSpacing: CGFloat = 5.0
    
    var favoritesView = FavoritesView()
   
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setDelegates()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func addSubviews() {
        self.view.addSubview(favoritesView.collectionView)
    }
    
    private func setDelegates() {
        favoritesView.collectionView.dataSource = self
        favoritesView.collectionView.delegate = self
    }

    private func loadData() {
        guard let cityName = cityName else {return}
        
        PhotoAPIClient.manager.getPhotos(city: cityName.replacingOccurrences(of: " ", with: "")) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let photos):
                self.photos = photos
            }
        }
    }

}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoritesView.collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoritesCollectionViewCell else {return UICollectionViewCell()}
        let urlStr = photos[indexPath.row].webformatURL
        ImageManager.manager.getImage(urlStr: urlStr) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        
        return cell
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numCells: CGFloat = 1
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
