//
//  RatingMenuManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RatingSliderManager: ObjectManager {
                
    lazy var ratingSliderMenu: RatingSlider = {
        let optionsMenu = RatingSlider()
        optionsMenu.backgroundColor = UIColor(named: Colors.lmBackground.color)
        let genreOptions = [Genre]()
        return optionsMenu
    }()
    
    override func activateButton(bool: Bool) {
        isOn = bool
        
        let lightMode = UIColor(named: Colors.lmBackground.color)
        let darkMode = UIColor(named: Colors.dmBackground.color)
        ratingSliderMenu.backgroundColor = bool ? darkMode : lightMode
    }
        
    func presentSlider(direction: LaunchDirection) {
        ratingSliderMenu.minimumRating = 5.0
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            
            window.addSubview(fadeBackgroundView)
            window.addSubview(ratingSliderMenu)

            fadeBackgroundView.frame = window.frame
            fadeBackgroundView.alpha = 0
            fadeBackgroundView.backgroundColor = UIColor.black
            
            let screenWidth = window.frame.width
            let screenHeight = window.frame.height
            let topBarHeight = screenHeight / 14
            let padding = (3 * screenHeight) / 14
            
            if direction == .fromRight {
    
                let width = screenWidth * (2/3)
                let height = screenHeight - padding - topBarHeight
                let xOffset: CGFloat = screenWidth
                let yOffset: CGFloat = (padding / 2) + topBarHeight
                
                ratingSliderMenu.launchDirection = .fromRight
                ratingSliderMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSliderToRight(sender:))))
                let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissSliderToRight(sender:)))
                swipeRightGesture.direction = .right
                ratingSliderMenu.addGestureRecognizer(swipeRightGesture)
                
                let maskPath = UIBezierPath(roundedRect: ratingSliderMenu.bounds,
                                            byRoundingCorners: [.topLeft, .bottomLeft],
                                            cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                ratingSliderMenu.layer.mask = shape

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.fadeBackgroundView.alpha = 0.4
                        self.ratingSliderMenu.center.x -= self.ratingSliderMenu.bounds.width
                },
                    completion: nil)
                
            } else {

                let width = screenWidth * (2/3)
                let height = screenHeight - padding - topBarHeight
                let xOffset: CGFloat = -width
                let yOffset: CGFloat = (padding / 2) + topBarHeight
                
                ratingSliderMenu.launchDirection = .fromLeft
                ratingSliderMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSliderToLeft(sender:))))
                let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissSliderToLeft(sender:)))
                swipeLeftGesture.direction = .left
                ratingSliderMenu.addGestureRecognizer(swipeLeftGesture)
                
                let maskPath = UIBezierPath(roundedRect: ratingSliderMenu.bounds,
                                            byRoundingCorners: [.topRight, .bottomRight],
                                            cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                ratingSliderMenu.layer.mask = shape

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.fadeBackgroundView.alpha = 0.4
                        self.ratingSliderMenu.center.x += self.ratingSliderMenu.bounds.width
                },
                    completion: nil)
            }
        
        }
    }
                
    @objc private func dismissSliderToRight(sender: UISwipeGestureRecognizer) {
        if ratingSliderMenu.minimumRating >= 0 {
            User.rightUser.selectedRating = ratingSliderMenu.minimumRating
            print("Stored: \(ratingSliderMenu.minimumRating)")
            // If we have 1 or more items in selection we are allowed to dismiss
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.ratingSliderMenu.center.x += self.ratingSliderMenu.bounds.width
            },
                completion: nil)
        } else {
            print("LEFT side empty") // otherwise inform user in some way
        }
    }
    
    @objc private func dismissSliderToLeft(sender: UISwipeGestureRecognizer) {
        if ratingSliderMenu.minimumRating >= 0 {
            User.leftUser.selectedRating = ratingSliderMenu.minimumRating
            print("Stored: \(ratingSliderMenu.minimumRating)")
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.ratingSliderMenu.center.x -= self.ratingSliderMenu.bounds.width
            },
                completion: nil)
        } else {
            print("RIGHT side empty")
        }
    }
    
}
