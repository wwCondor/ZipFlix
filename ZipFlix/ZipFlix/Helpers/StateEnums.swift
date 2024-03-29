//
//  StateEnums.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// Handles dark and light mode (can be handled different now since assets allows for dm colors)
enum ModeSelected {
    case lightMode
    case darkMode
}

// Handles direction from which selection menu is presented
enum LaunchDirection {
    case fromRight
    case fromLeft
}

// Handles open or closed state of zipper
enum ZipperState {
    case open
    case closed
}
