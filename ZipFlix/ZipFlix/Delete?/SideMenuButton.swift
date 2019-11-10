//
//  SideMenuButton.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 06/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

//import UIKit
//
//class SideMenuButton: ToggleButton {
//    
//    override func setupButton() {
//        addObservers()
//        let image = UIImage(named: Icons.reset.image)?.withRenderingMode(.alwaysTemplate)
//        tintColor = .white
//        setImage(image, for: .normal)
//        imageView?.contentMode = .scaleAspectFit
//        contentMode = .center
//        backgroundColor = UIColor(named: Colors.sideButton.color)
//        let inset: CGFloat = 10
//        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//        layer.masksToBounds = false
//        layer.cornerRadius = Constants.menuCornerRadius
////        layer.borderWidth = 3
////        let borderColor = UIColor(named: Colors.border.color)
////        layer.borderColor = borderColor?.cgColor
//    }
//    
//    override func activateButton(bool: Bool) {
//        isOn = bool
//        
//        let lightModeTint = UIColor.white
//        let darkModeTint = UIColor.black
//        tintColor = bool ? darkModeTint : lightModeTint
//    }
//}
//
//// The button class that gets its appearance altered by a notification posted by modeToggleButton
//class ToggleButton: CustomButton {
//    
//    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
//    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
//    
//    override func setupButton() {
//    }
//    
//    override func addObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: lightModeNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: darkModeNotification, object: nil)
//    }
//    
//    @objc func toggleState(notification: NSNotification) {
//        activateButton(bool: !isOn)
//    }
//    
//    func activateButton(bool: Bool) {
//
//    }
//}
