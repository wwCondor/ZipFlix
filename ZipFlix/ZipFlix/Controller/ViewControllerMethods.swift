//
//  ViewControllerMethods.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

extension ViewController {
    
    @objc func clearInput(sender: UIButton) {
        openZipper()
        
        // When button is pressed we should reset selection data
        // First we post notification for observers of object who need to reset something
        NotificationCenter.default.post(name: clearInputNotification, object: nil)

        leftSelectionMenu.leftSideHasSelectedGenres = false
        leftSelectionMenu.selectionMenu.reloadData()
        
        rightSelectionMenu.rigthSideHasSelectedGenres = false
        rightSelectionMenu.selectionMenu.reloadData()

        
        print("Cleared Input")

    }
    
    @objc func switchMode(sender: UIButton) {
        let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
        let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
        
        if modeSelected == .darkMode {
            // In here we switch modeSelected
            self.modeSelected = .lightMode
            
            // We set and update statusBar
            self.style = .lightContent
            self.setNeedsStatusBarAppearanceUpdate()
            
            // We set notification in notificationCenter
            NotificationCenter.default.post(name: lightModeNotification, object: nil)

            // Change background
            self.view.backgroundColor = UIColor(named: Colors.lmBackground.color)

        } else if modeSelected == .lightMode {
            self.modeSelected = .darkMode
            
            self.style = .darkContent
            self.setNeedsStatusBarAppearanceUpdate()
            
            NotificationCenter.default.post(name: darkModeNotification, object: nil)
            
            self.view.backgroundColor = UIColor(named: Colors.dmBackground.color)

        }
    }

    @objc func runAnimation(tapGestureRecognizer: UITapGestureRecognizer) {
        // Animation method for logo (optional)
        print("Animation started")
    }
    
    @objc func suggestMovie(sender: UIButton) {
        closeZipper()
        print("Start Loading")
        print("Present Movie Suggestion")
        print("Stop Loading")
    }
}


