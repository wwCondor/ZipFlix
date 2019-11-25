//
//  CustomButtons.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ModeToggleButton: CustomButton {
    
    var isDimmed = false
    
    let dimmerNotification = Notification.Name(rawValue: Constants.dimNotificationKey)
    let cancelDimmerNotification = Notification.Name(rawValue: Constants.cancelDimNotificationKey)

    override func setupButton() {
        let image = UIImage(named: Icons.lightModeIcon.image)!.withRenderingMode(.alwaysOriginal)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentMode = .center
        backgroundColor = Constants.barButtonItemsColor
        let inset: CGFloat = Constants.iconInset
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset + Constants.topBarIconOffset, bottom: inset + 3, right: inset)
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDimmer), name: dimmerNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleDimmer), name: cancelDimmerNotification, object: nil)
    }

    // Dimmer Toggle
    @objc private func toggleDimmer(notification: NSNotification) {
        activateDimmer(bool: !isDimmed)
    }

    private func activateDimmer(bool: Bool) {
        // Dims button image during disable
        isDimmed = bool

        let dimmedAlpha = Constants.dimAlpha
        let normalAlpha: CGFloat = 1.0
        let alpha = bool ? dimmedAlpha : normalAlpha
        self.alpha = alpha
    }
    
    // Mode image toggle 
    @objc private func buttonPressed(sender: UIButton) {
        activateButton(bool: !isOn)
    }
    
    private func activateButton(bool: Bool) {
        isOn = bool
        
        let lightModeIcon = UIImage(named: Icons.lightModeIcon.image)?.withRenderingMode(.alwaysOriginal)
        let darkModeIcon = UIImage(named: Icons.darkModeIcon.image)?.withRenderingMode(.alwaysTemplate)
        let image = bool ? darkModeIcon : lightModeIcon
        setImage(image, for: .normal)
        
        let darkModeTint = UIColor.black
        tintColor = bool ? darkModeTint : nil
    }
    
}
