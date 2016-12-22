//
//  MyStuffTableViewCell.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-15.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit

class MyStuffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithItem(item: Item) {
        pictureView.image = UIImage(data:item.image as! Data)
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }


}
