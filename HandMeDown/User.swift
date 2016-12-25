//
//  User.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-07.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation

class User: NSObject {
    var name = ""
    var picture : Data? = nil
    convenience public init(name:String, picture: Data) {
        self.init()
        self.name = name
        self.picture = picture
    }
}



