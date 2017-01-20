//
//  Item.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation


class Item: NSObject {
    var title = ""
    var itemDescription = ""
    var image : String = ""
    var like: Bool = false
    var users = [User]()
    
    
    convenience init(title: String, itemDescription: String, image: String, like:Bool, users: [User]) {
    self.init()
    self.title = title
    self.itemDescription = itemDescription
    self.image = image
    self.like = false
    self.users = users
    }
}




