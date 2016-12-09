//
//  User.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation

class User {
    var firstName: String
    var lastName: String
    var image: String
    var items: [Item]
    
    
    init(firstName:String, lastName: String, image: String, items:[Item]) {
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        self.items = items
    }
    
    
}


