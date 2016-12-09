//
//  GoodiesCollectionViewCell.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit

class GoodiesCollectionViewCell: UICollectionViewCell {
    
  
    // properties
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userPictureView: UIImageView!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var likeView: UIImageView!
    
    
    var item: Item? {
        didSet {
            if let item = item {
                imageView.image = UIImage(named: item.image)
                itemDescriptionLabel.text = item.title
                likeView.image = UIImage(named: item.like)
            }
        }
    }
    
    var user: User? {
        didSet {
            if let user = user {
                userPictureView.image = UIImage(named: user.image)
            }
        }
    }
    
}

