//
//  FavoritesCollectionViewCell.swift
//  WeatherApp
//
//  Created by Levi Davis on 10/11/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        [imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor), imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
         imageView.widthAnchor.constraint(equalToConstant: 400),
         imageView.heightAnchor.constraint(equalToConstant: 350)].forEach{ $0.isActive = true
        }
    }
    
}
