//
//  Item.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation

class Item {
    var title: String
    var itemDescription: String
    var image: String
    var like: String
    var category: String
    
    
    init(title:String, itemDescription: String, image: String, like: String, category: String) {
        self.title = title
        self.itemDescription = itemDescription
        self.image = image
        self.like = like
        self.category = category
    }
    
    
}
