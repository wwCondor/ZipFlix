//
//  PersonMenuManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 17/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class PersonMenuManager: ObjectManager {
                
    lazy var peopleOptionsMenu: PersonOptionsMenu = {
        let optionsMenu = PersonOptionsMenu()
        optionsMenu.backgroundColor = UIColor(named: Colors.lmBackground.color)
        let genreOptions = [Person]()
        return optionsMenu
    }()
    
    override func activateButton(bool: Bool) {
        isOn = bool
        
        let lightMode = UIColor(named: Colors.lmBackground.color)
        let darkMode = UIColor(named: Colors.dmBackground.color)
        peopleOptionsMenu.backgroundColor = bool ? darkMode : lightMode
    }
        
    func presentOptions(direction: LaunchDirection) {
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            
            window.addSubview(fadeBackgroundView)
            window.addSubview(peopleOptionsMenu)

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
                
                peopleOptionsMenu.launchDirection = .fromRight
                peopleOptionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptionsToRight(sender:))))
                let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissOptionsToRight(sender:)))
                swipeRightGesture.direction = .right
                peopleOptionsMenu.addGestureRecognizer(swipeRightGesture)
                
                let maskPath = UIBezierPath(roundedRect: peopleOptionsMenu.bounds,
                                            byRoundingCorners: [.topLeft, .bottomLeft],
                                            cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                peopleOptionsMenu.layer.mask = shape

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.fadeBackgroundView.alpha = 0.4
                        self.peopleOptionsMenu.center.x -= self.peopleOptionsMenu.bounds.width
                },
                    completion: nil)
                
            } else {

                let width = screenWidth * (2/3)
                let height = screenHeight - padding - topBarHeight
                let xOffset: CGFloat = -width
                let yOffset: CGFloat = (padding / 2) + topBarHeight
                
                peopleOptionsMenu.launchDirection = .fromLeft
                peopleOptionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptionsToLeft(sender:))))
                let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissOptionsToLeft(sender:)))
                swipeLeftGesture.direction = .left
                peopleOptionsMenu.addGestureRecognizer(swipeLeftGesture)
                
                let maskPath = UIBezierPath(roundedRect: peopleOptionsMenu.bounds,
                                            byRoundingCorners: [.topRight, .bottomRight],
                                            cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                peopleOptionsMenu.layer.mask = shape

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.fadeBackgroundView.alpha = 0.4
                        self.peopleOptionsMenu.center.x += self.peopleOptionsMenu.bounds.width
                },
                    completion: nil)
            }
        
        }
    }
                
    @objc private func dismissOptionsToRight(sender: UISwipeGestureRecognizer) {
        if peopleOptionsMenu.leftSideSelectedPeople.count != 0 {
            // If we have 1 or more items in selection we are allowed to dismiss
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.peopleOptionsMenu.center.x += self.peopleOptionsMenu.bounds.width
            },
                completion: nil)
        } else {
            print("LEFT side empty") // otherwise inform user in some way
        }
    }
    
    @objc private func dismissOptionsToLeft(sender: UISwipeGestureRecognizer) {
        if peopleOptionsMenu.rightSideSelectedPeople.count != 0 {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.peopleOptionsMenu.center.x -= self.peopleOptionsMenu.bounds.width
            },
                completion: nil)
        } else {
            print("RIGHT side empty")
        }
    }
    
}
