//
//  SideMenuButton.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 06/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SideMenuButton: ToggleButton {
    
    override func setupButton() {
        addObservers()
        let image = UIImage(named: Icons.reset.image)?.withRenderingMode(.alwaysTemplate)
        tintColor = .white
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentMode = .center
        backgroundColor = UIColor.red
        let inset: CGFloat = 0
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    override func activateButton(bool: Bool) {
        isOn = bool
        
        let lightModeTint = UIColor.red
        let darkModeTint = UIColor.black
        tintColor = bool ? darkModeTint : lightModeTint
    }
}


// The button class that gets it state swiched by modeToggleButton
class ToggleButton: CustomButton {
    
    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
    
    override func setupButton() {
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: lightModeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: darkModeNotification, object: nil)
    }
    
    @objc func toggleState(notification: NSNotification) {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
//        isOn = bool
//
//        let lightModeTint = UIColor.white
//        let darkModeTint = UIColor.black
//        tintColor = bool ? darkModeTint : lightModeTint
    }
}
