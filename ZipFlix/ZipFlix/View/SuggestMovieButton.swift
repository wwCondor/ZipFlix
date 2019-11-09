//
//  SuggestMovieButton.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SuggestMovieButton: CustomButton {
    
    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
    
    override func setupButton() {
        let image = UIImage(named: Icons.movieIcon.image)?.withRenderingMode(.alwaysOriginal)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentMode = .center
        backgroundColor = UIColor(named: Colors.sideMenuView.color)
        let inset: CGFloat = Constants.movieIconInset
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layer.masksToBounds = false
        layer.cornerRadius = Constants.movieButtonCornerRadius
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
        
        // Change alpha when light/dark mode is enabled
        let lightModeIcon = UIImage(named: Icons.movieIcon.image)?.withRenderingMode(.alwaysOriginal)
        let darkModeIcon = UIImage(named: Icons.movieIcon.image)!.alpha(0.5)
        let image = bool ? darkModeIcon : lightModeIcon
        setImage(image, for: .normal)
    }
}



