//
//  PhotoCell.swift
//  UnSplash Photos
//
//  Created by Yaroslav on 17.11.2020.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet var imageView: ImageView!

    func configure(food: Food) {
        guard let imageURL = food.urls["thumb"] else { return }
        imageView.fetchImage(url: imageURL)

    }
}
