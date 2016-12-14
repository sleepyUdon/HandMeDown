//
//  Category.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-12.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    dynamic var name = ""
    
    
    convenience public init(name:String){
        self.init()
        self.name = name
    }
}
