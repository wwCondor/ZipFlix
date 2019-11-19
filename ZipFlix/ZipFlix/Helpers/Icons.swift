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
    case movieIcon
    case zipperIcon
    case zipperThumb
    case bubbleEmpty
    case bubbleSelected
    
    case poster
    
    var image: String {
        switch self {
        case .darkModeIcon:     return "DarkMode"
        case .lightModeIcon:    return "LightMode"
        case .reset:            return "Reset"
        case .movieIcon:        return "MovieIcon"
        case .zipperIcon:       return "ZipperIcon"
        case .zipperThumb:      return "ZipperThumb" // 30x30
        case .bubbleEmpty:      return "BubbleEmpty"
        case .bubbleSelected:   return "BubbleSelected"
            
        case .poster: return "TestPoster"
        }
    }
    
}
