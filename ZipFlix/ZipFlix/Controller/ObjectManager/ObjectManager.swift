//
//  ObjectManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 19/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// Superclass for objects that mange present/present of selection menus
class ObjectManager: NSObject {
    
    
    var isOn = false
    
    let fadeBackgroundView = UIView()

    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
    
    override init() {
        super.init()
        addObserver()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setBackgroundColor), name: lightModeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setBackgroundColor), name: darkModeNotification, object: nil)
    }
    
    @objc private func setBackgroundColor(notification: NSNotification) {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
