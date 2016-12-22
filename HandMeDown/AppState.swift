//
//  AppState.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-21.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    static let sharedInstance = AppState()
    
    var signedIn = false
    var displayName: String?
    var photoURL: URL?
}
