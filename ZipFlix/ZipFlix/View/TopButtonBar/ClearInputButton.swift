//
//  ClearInputButton.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ClearInputButton: CustomButton {
    
    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
    
    override func setupButton() {
        let image = UIImage(named: Icons.reset.image)?.withRenderingMode(.alwaysTemplate)
        tintColor = .white
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentMode = .center
        backgroundColor = Constants.barButtonItemsColor
        let inset: CGFloat = Constants.iconInset + 1
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset + 3, right: inset + Constants.topBarIconOffset)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: lightModeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: darkModeNotification, object: nil)
    }
    
    @objc private func toggleState(notification: NSNotification) {
        activateButton(bool: !isOn)
    }
    
    private func activateButton(bool: Bool) {
        isOn = bool
        
        let lightModeTint = UIColor.white
        let darkModeTint = UIColor.black
        tintColor = bool ? darkModeTint : lightModeTint
    }
}
