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
        print("Cleared Input")
    }
    
    @objc func switchMode(sender: UIButton) {
        let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
        let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)

        if modeSelected == .darkMode {
            self.modeSelected = .lightMode
            
            self.style = .lightContent
            self.setNeedsStatusBarAppearanceUpdate()
            
            NotificationCenter.default.removeObserver(darkModeNotification)
            NotificationCenter.default.post(name: lightModeNotification, object: nil)

            self.view.backgroundColor = UIColor(named: Colors.lmBackground.color)
            DispatchQueue.main.async {
                
            }

        } else if modeSelected == .lightMode {
            self.modeSelected = .darkMode
            
            self.style = .darkContent
            self.setNeedsStatusBarAppearanceUpdate()
            
            NotificationCenter.default.removeObserver(lightModeNotification)
            NotificationCenter.default.post(name: darkModeNotification, object: nil)

            self.view.backgroundColor = UIColor(named: Colors.dmBackground.color)
            DispatchQueue.main.async {
                
            }
        }
    }

    @objc func runAnimation(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Animation started")
    }
    
    @objc func suggestMovie(sender: UIButton) {
        closeZipper()
        print("Start Loading")
        print("Present Movie Suggestion")
        print("Stop Loading")
    }
}

