//
//  LogoImageView.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class LogoImageView: UIImageView {
    var isOn = false
    
//    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
//    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
    
    override init(image: UIImage?) {
        super.init(image: image)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        addObservers()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        addObservers()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        tintColor = UIColor.white
        backgroundColor = Constants.barButtonItemsColor
//        frame = CGRect(x: -38, y: -14, width: Constants.logoSize, height: Constants.logoSize)
//        let inset: CGFloat = 6
//        image?.alignmentRectInsets(UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset + Constants.navBarIconOffset))
        contentMode = .scaleToFill
        isUserInteractionEnabled = true // Only needed if when implementing animation/sound
        translatesAutoresizingMaskIntoConstraints = false
    }
//    
//    func addObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: lightModeNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: darkModeNotification, object: nil)
//    }
//
//    @objc private func toggleState(notification: NSNotification) {
//        activateButton(bool: !isOn)
//    }
//
//    private func activateButton(bool: Bool) {
//        isOn = bool
//
//        // Changes alpha when dark mode is selected
//
//    }
//
}
