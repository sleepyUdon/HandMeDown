//
//  Item.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation
import RealmSwift


class Item: Object {
    dynamic var title = ""
    dynamic var itemDescription = ""
    dynamic var image = ""
    dynamic var like = ""
    dynamic var category = ""
    
    
    convenience public init(title:String, itemDescription: String, image: String, like: String, category: String) {
        self.init()
        self.title = title
        self.itemDescription = itemDescription
        self.image = image
        self.like = like
        self.category = category
    }
    
    
}




