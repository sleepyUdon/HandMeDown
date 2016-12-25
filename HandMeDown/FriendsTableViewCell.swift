//
//  FriendsTableViewCell.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-24.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    /// MARK: properties
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var itemsNumberLabel: UILabel!
    
    // convenience initializer
    func configureWithUser(user: User) {
        pictureView.image = UIImage(data: user.picture!)
        friendNameLabel.text = user.name
    }

}



