//
//  User.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var image = ""
//    var items = List<Item>()
    
    
//    convenience public init(firstName:String, lastName: String, image: String, items:[Item]) {
    //
    convenience public init(firstName:String, lastName: String, image: String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
        //        self.items = items
    }
    
    
}



