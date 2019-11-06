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
        let dimmerNotification = Notification.Name(rawValue: Constants.dimNotificationKey)
        NotificationCenter.default.removeObserver(dimmerNotification)
    }
    
    @objc func switchMode(sender: UIButton) {
        let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
        let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
        
        let alphaValue: CGFloat = 0.5

        if modeSelected == .darkMode {
            // In here we switch modeSelected
            self.modeSelected = .lightMode
            
            // We set and update statusBar
            self.style = .lightContent
            self.setNeedsStatusBarAppearanceUpdate()
            
            // We update notificationCenter
            NotificationCenter.default.removeObserver(darkModeNotification)
            NotificationCenter.default.post(name: lightModeNotification, object: nil)

            // Change background
            self.view.backgroundColor = UIColor(named: Colors.lmBackground.color)
            
            // Dim/undim zippers
            self.leftZipperOne.zipperColor = UIColor(named: Colors.zipper.color)!
            self.leftZipperTwo.zipperColor = UIColor(named: Colors.zipper.color)!
            self.leftZipperThree.zipperColor = UIColor(named: Colors.zipper.color)!
            self.leftZipperFour.zipperColor = UIColor(named: Colors.zipper.color)!

            self.rightZipperOne.zipperColor = UIColor(named: Colors.zipper.color)!
            self.rightZipperTwo.zipperColor = UIColor(named: Colors.zipper.color)!
            self.rightZipperThree.zipperColor = UIColor(named: Colors.zipper.color)!
            self.rightZipperFour.zipperColor = UIColor(named: Colors.zipper.color)!

//            DispatchQueue.main.async {  }

        } else if modeSelected == .lightMode {
            self.modeSelected = .darkMode
            
            self.style = .darkContent
//            self.setNeedsStatusBarAppearanceUpdate()
            
            NotificationCenter.default.removeObserver(lightModeNotification)
            NotificationCenter.default.post(name: darkModeNotification, object: nil)
            
            self.view.backgroundColor = UIColor(named: Colors.dmBackground.color)
            
            self.leftZipperOne.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            self.leftZipperTwo.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            self.leftZipperThree.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            self.leftZipperFour.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)

            self.rightZipperOne.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            self.rightZipperTwo.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            self.rightZipperThree.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            self.rightZipperFour.zipperColor = UIColor(named: Colors.zipper.color)!.withAlphaComponent(alphaValue)
            
//            DispatchQueue.main.async { } // Might need to move everything in here
        }
    }

    @objc func runAnimation(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Animation started")
    }
    
    @objc func suggestMovie(sender: UIButton) {
        let dimmerNotification = Notification.Name(rawValue: Constants.dimNotificationKey)
        NotificationCenter.default.post(name: dimmerNotification, object: nil)
        
        closeZipper()
        print("Start Loading")
        print("Present Movie Suggestion")
        print("Stop Loading")
    }
}

