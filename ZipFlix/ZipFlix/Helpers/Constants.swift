//
//  Constants.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

struct Constants {
    // notification keys
    static let lightModeNotificationKey = "lightMode"
    static let darkModeNotificationKey = "darkMode"
    
    static let dimNotificationKey = "dimmedMode"
    static let cancelDimNotificationKey = "cancelDimmedMode"
    
    static let iconSize: CGFloat = 30
    static let logoSize: CGFloat = 80
    static let iconInset: CGFloat = 15
    
    // 
    static let topBarIconOffset: CGFloat = 8
    static let topBarHeigth: CGFloat = 58
    static let barLogoHeight: CGFloat = 92
    
    // Colors
    static let barButtonItemsColor: UIColor = .clear // topbar item background color
    static let sideMenuViewColor: UIColor = UIColor.gray
    
    
    static let movieButtonSize: CGFloat = 90
    static let movieButtonCornerRadius: CGFloat = 15
    static let movieIconInset: CGFloat = 15

    // Side menu constants
    static let menuCornerRadius: CGFloat = 15
    static let topOffset: CGFloat = 100
    static let bottomOffset: CGFloat = -90
}

