//
//  FavoritesView.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/10/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.frame = bounds
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "favoriteCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func commonInit() {
        viewSetup()
    }
    
    private func viewSetup() {
        addSubview(collectionView)
    }
}
