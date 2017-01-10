//
//  MyProfile.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-24.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import RealmSwift


class MyProfile: Object {
    dynamic var name = ""
    dynamic var image : Data? = nil
    dynamic var userID = ""

    
    convenience public init(name:String, image: Data, userID: String) {
        self.init()
        self.name = name
        self.image = image
        self.userID = userID
    }
}
