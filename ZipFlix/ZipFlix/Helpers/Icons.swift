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
    case emptyBucket
    case movieIcon
    case zipperIcon
    case zipperThumb
    case bubbleEmpty
    case bubbleSelected
    case noPoster
    
    var image: String {
        switch self {
        case .darkModeIcon:     return "DarkMode"
        case .lightModeIcon:    return "LightMode"
        case .reset:            return "Reset"
        case .emptyBucket:      return "EmptyBucket"
        case .movieIcon:        return "MovieIcon"
        case .zipperIcon:       return "ZipperIcon"
        case .zipperThumb:      return "ZipperThumb" // 30x30
        case .bubbleEmpty:      return "BubbleEmpty"
        case .bubbleSelected:   return "BubbleSelected"
        case .noPoster:         return "NoPoster"
        }
    }
    
}
