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
    dynamic var image : NSData? = nil
    dynamic var like = ""
    var categories = List<Category>()
    dynamic var user = ""
    
    convenience public init(title:String, itemDescription: String, image: NSData, like: String, categories: List<Category>, user: String) {
        self.init()
        self.title = title
        self.itemDescription = itemDescription
        self.image = image
        self.like = like
        self.categories = categories
        self.user = user
    }
}




