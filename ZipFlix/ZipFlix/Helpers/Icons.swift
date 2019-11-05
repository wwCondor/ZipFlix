//
//  Icons.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum Icons {
    case darkModeIcon
    case lightModeIcon
    case reset
    case clapperboard
    case zipperIcon
    
    var image: String {
        switch self {
        case .darkModeIcon: return "DarkMode"
        case .lightModeIcon: return "LightMode"
        case .reset: return "Reset"
        case .clapperboard: return "Clapperboard"
        case .zipperIcon: return "ZipperIcon"
            
        }
    }
    
}
