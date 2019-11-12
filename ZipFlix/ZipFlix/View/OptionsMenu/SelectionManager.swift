//
//  SelectionManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SelectionManager: NSObject {
        
    let fadeBackgroundView = UIView()
    
    var modeSelected: ModeSelected = .lightMode
    
    lazy var optionsMenu: OptionsMenu = {
        let optionsMenu = OptionsMenu()
//        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
//        swipeLeftGesture.direction = .left
//        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
//        swipeRightGesture.direction = .right
//        movieSuggestions.addGestureRecognizer(swipeLeftGesture)
//        movieSuggestions.addGestureRecognizer(swipeRightGesture)
        return optionsMenu
    }()
        
    func presentOptions() {
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            
            window.addSubview(fadeBackgroundView)
            window.addSubview(optionsMenu)

            fadeBackgroundView.frame = window.frame
            fadeBackgroundView.alpha = 0
            fadeBackgroundView.backgroundColor = UIColor.black
            fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptions(sender:))))
                        
            if modeSelected == .lightMode {
                optionsMenu.backgroundColor = UIColor(named: Colors.lmBackground.color)
            } else if modeSelected == .darkMode {
                optionsMenu.backgroundColor = UIColor(named: Colors.dmBackground.color)
            }
            
            let screenWidth = window.frame.width
            let screenHeight = window.frame.height
            let topBarHeight = screenHeight / 14
            let padding = (3 * screenHeight) / 14
            let width = (screenWidth * (2/3)) - (screenWidth / 24)
            let height = screenHeight - padding - topBarHeight
            let xOffset: CGFloat = screenWidth
            let yOffset: CGFloat = (padding / 2) + topBarHeight
            
            optionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
//            optionsMenu.alpha = 0
            
            let maskPath = UIBezierPath(roundedRect: optionsMenu.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            optionsMenu.layer.mask = shape

            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeBackgroundView.alpha = 0.4
                    self.optionsMenu.center.x -= self.optionsMenu.bounds.width
            },
                completion: nil)
        }
    }
        
    @objc private func dismissOptions(sender: UISwipeGestureRecognizer) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeBackgroundView.alpha = 0
                self.optionsMenu.center.x += self.optionsMenu.bounds.width
        },
            completion: nil)
    }
}
