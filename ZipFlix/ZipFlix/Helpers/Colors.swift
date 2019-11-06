//
//  Colors.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum ModeSelected {
    case lightMode
    case darkMode
    
}

enum ZipperState {
    case open
    case closed
}

enum Colors {
    case dmBackground
    case dmNavBar
    
    case lmBackground
    case lmNavBar
    
    case lmStatusBar
    
    case sideMenuView
    case zipper
    case zipperBorder
    
    var color: String {
        switch self {
        case .dmBackground: return "DMBackground"
        case .dmNavBar: return "DMNavBar"
            
        case .lmBackground: return "LMBackground"
        case .lmNavBar: return "LMNavBar"
            
        case .lmStatusBar: return "LMStatusBar"
            
        case .sideMenuView: return "SideMenuView"
        case .zipper: return "Zipper"
        case .zipperBorder: return "ZipperBorder"
        }
    }
}


// Migth be useful for some future feature 
enum TriStateSwitch {
    case off
    case low
    case high
    mutating func next() {
        switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
            self = .off
        }
    }
}

//var ovenLight = TriStateSwitch.off
//ovenLight.next() // ovenLight is now equal to .low
//ovenLight.next() // ovenLight is now equal to .high
//ovenLight.next() // ovenLight is now equal to .off again




