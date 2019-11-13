//
//  SelectionManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SelectionViewManager: NSObject {
        
    let fadeBackgroundView = UIView()
    
    var modeSelected: ModeSelected = .lightMode
        
    lazy var optionsMenu: OptionsMenu = {
        let optionsMenu = OptionsMenu()
        return optionsMenu
    }()
        
    func presentOptions(direction: LaunchDirection) {
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            
            window.addSubview(fadeBackgroundView)
            window.addSubview(optionsMenu)

            fadeBackgroundView.frame = window.frame
            fadeBackgroundView.alpha = 0
            fadeBackgroundView.backgroundColor = UIColor.black
                        
            if modeSelected == .lightMode {
                optionsMenu.backgroundColor = UIColor(named: Colors.lmBackground.color)
            } else if modeSelected == .darkMode {
                optionsMenu.backgroundColor = UIColor(named: Colors.dmBackground.color)
            }
            
            let screenWidth = window.frame.width
            let screenHeight = window.frame.height
            let topBarHeight = screenHeight / 14
            let padding = (3 * screenHeight) / 14
            
            if direction == .fromRight {
    
                let width = screenWidth * (2/3)
                let height = screenHeight - padding - topBarHeight
                let xOffset: CGFloat = screenWidth
                let yOffset: CGFloat = (padding / 2) + topBarHeight
                
                optionsMenu.launchDirection = .fromRight
                optionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptionsToRight(sender:))))
                let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissOptionsToRight(sender:)))
                swipeRightGesture.direction = .right
                optionsMenu.addGestureRecognizer(swipeRightGesture)
                
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
                
            } else {

                let width = screenWidth * (2/3)
                let height = screenHeight - padding - topBarHeight
                let xOffset: CGFloat = -width
                let yOffset: CGFloat = (padding / 2) + topBarHeight
                
                optionsMenu.launchDirection = .fromLeft
                optionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptionsToLeft(sender:))))
                let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissOptionsToLeft(sender:)))
                swipeLeftGesture.direction = .left
                optionsMenu.addGestureRecognizer(swipeLeftGesture)
                
                let maskPath = UIBezierPath(roundedRect: optionsMenu.bounds,
                                            byRoundingCorners: [.topRight, .bottomRight],
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
                        self.optionsMenu.center.x += self.optionsMenu.bounds.width
                },
                    completion: nil)
            }
        
        }
    }
                
    @objc private func dismissOptionsToRight(sender: UISwipeGestureRecognizer) {
        if optionsMenu.leftSideSelectedGenres.count != 0 {
            // If we have 1 or more items in selection we are allowed to dismiss
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.optionsMenu.center.x += self.optionsMenu.bounds.width
            },
                completion: nil)
        } else {
            print("LEFT side empty") // otherwise inform user in some way
        }
    }
    
    @objc private func dismissOptionsToLeft(sender: UISwipeGestureRecognizer) {
        if optionsMenu.rightSideSelectedGenres.count != 0 {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.optionsMenu.center.x -= self.optionsMenu.bounds.width
            },
                completion: nil)
        } else {
            print("RIGHT side empty")
        }
    }
}
