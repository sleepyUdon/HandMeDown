//
//  GoodiesCollectionViewCell.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit

class GoodiesCollectionViewCell: UICollectionViewCell {
    
    
    /// MARK: properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userPictureView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
//     convenience initializer
//    func configureWithItem(item: Item) {
//        imageView.image = UIImage(data:item.image!)
////        userPictureView?.image = UIImage(named: item.users)
//        titleLabel.text = item.title
////        likeButton.imageView?.image = UIImage(named: item.like)
//    }
}

