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
            favoritesCollectionView.reloadData()
        }
    }
    
    var cityName: String!
    
    let cellSpacing: CGFloat = 5.0
    
    var favoritesView = FavoritesView()
    lazy var favoritesCollectionView = favoritesView.collectionView
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func addSubviews() {
        self.view.addSubview(favoritesCollectionView)
    }
    
    private func setDelegates() {}

    private func loadData() {
        PhotoAPIClient.manager.getPhotos(city: cityName) { (result) in
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
        return UICollectionViewCell()
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
