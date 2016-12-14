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
    @IBOutlet weak var userPictureView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeView: UIImageView!
    


func configureWithItem(item: Item) {
    imageView.image = UIImage(data:item.image as! Data)
    userPictureView?.image = UIImage(named: item.user)
    titleLabel.text = item.title
    likeView.image = UIImage(named: item.like)
}
}

