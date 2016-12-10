//
//  Fonts.swift
//  HandMeDown
//
//  Created by Viviane Chan on 2016-12-10.
//  Copyright © 2016 Viviane Chan. All rights reserved.
//

import UIKit

open class Fonts: UIFont {
    
    // arial
    open class arial {
        open static let MT = UIFont(name: "ArialMT", size: 12.0)
        open static let boldMT = UIFont(name: "Arial-BoldMT", size: 12.0)
    }
    
    
    // Helvetica
    open class helvetica {
        open static let neue = UIFont(name: "HelveticaNeue", size: 12.0)
        open static let neuelight = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        open static let neueitalic = UIFont(name: "HelveticaNeue-Italic", size: 12.0)
        open static let neuebold = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
    }
    
    
    // Georgia
    open class georgia {
        open static let normal = UIFont(name: "Georgia", size: 12.0)
    }
    
    
    // Stagapp
    open class stagapp {
        open static let medium = UIFont(name: "StagApp-Medium", size: 18.0)
    }
}


