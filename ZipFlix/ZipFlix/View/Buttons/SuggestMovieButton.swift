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
        addObservers()
        let image = UIImage(named: Icons.movieIcon.image)?.withRenderingMode(.alwaysOriginal)
//        tintColor = .white
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentMode = .center
        backgroundColor = UIColor(named: Colors.sideMenuView.color)
        let inset: CGFloat = Constants.movieIconInset
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layer.masksToBounds = false
        layer.cornerRadius = Constants.movieButtonCornerRadius
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: lightModeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: darkModeNotification, object: nil)
    }
    
    @objc private func toggleState(notification: NSNotification) {
        activateButton(bool: !isOn)
    }
    
    private func activateButton(bool: Bool) {
        isOn = bool
        
        // Changes alpha when dark mode is selected
        let lightModeIcon = UIImage(named: Icons.movieIcon.image)?.withRenderingMode(.alwaysOriginal)
        let darkModeIcon = UIImage(named: Icons.movieIcon.image)!.alpha(0.5)
        let image = bool ? darkModeIcon : lightModeIcon
        setImage(image, for: .normal)
    }
}


extension UIImage {
    // Used to change alpha
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
