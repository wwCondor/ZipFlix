//
//  Colors.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum Colors {
    case dmBackground
    case lmBackground
    case objectBG
    case zipper
    case border
    
    var color: String {
        switch self {
        case .dmBackground:     return "DMBackground"
        case .lmBackground:     return "LMBackground"
        case .objectBG:         return "ObjectBackground"
        case .zipper:           return "Zipper"
        case .border:           return "Border"
        }
    }
}





