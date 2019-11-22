//
//  SelectionManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class GenreMenuManager: ObjectManager {
                
    lazy var genreOptionsMenu: GenreOptionMenu = {
        let optionsMenu = GenreOptionMenu()
        optionsMenu.backgroundColor = UIColor(named: Colors.lmBackground.color)
        let genreOptions = [Genre]()
        return optionsMenu
    }()
    
    override func activateButton(bool: Bool) {
        isOn = bool
        
        let lightMode = UIColor(named: Colors.lmBackground.color)
        let darkMode = UIColor(named: Colors.dmBackground.color)
        genreOptionsMenu.backgroundColor = bool ? darkMode : lightMode
    }
        
    func presentOptions(direction: LaunchDirection) {
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            
            window.addSubview(fadeBackgroundView)
            window.addSubview(genreOptionsMenu)

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
                
                genreOptionsMenu.launchDirection = .fromRight
                genreOptionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptionsToRight(sender:))))
                let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissOptionsToRight(sender:)))
                swipeRightGesture.direction = .right
                genreOptionsMenu.addGestureRecognizer(swipeRightGesture)
                
                let maskPath = UIBezierPath(roundedRect: genreOptionsMenu.bounds,
                                            byRoundingCorners: [.topLeft, .bottomLeft],
                                            cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                genreOptionsMenu.layer.mask = shape

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.fadeBackgroundView.alpha = 0.4
                        self.genreOptionsMenu.center.x -= self.genreOptionsMenu.bounds.width
                },
                    completion: nil)
                
            } else {

                let width = screenWidth * (2/3)
                let height = screenHeight - padding - topBarHeight
                let xOffset: CGFloat = -width
                let yOffset: CGFloat = (padding / 2) + topBarHeight
                
                genreOptionsMenu.launchDirection = .fromLeft
                genreOptionsMenu.frame = CGRect(x: xOffset , y: yOffset, width: width, height: height)
                
                fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissOptionsToLeft(sender:))))
                let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissOptionsToLeft(sender:)))
                swipeLeftGesture.direction = .left
                genreOptionsMenu.addGestureRecognizer(swipeLeftGesture)
                
                let maskPath = UIBezierPath(roundedRect: genreOptionsMenu.bounds,
                                            byRoundingCorners: [.topRight, .bottomRight],
                                            cornerRadii: CGSize(width: Constants.menuCornerRadius, height: Constants.menuCornerRadius))
                let shape = CAShapeLayer()
                shape.path = maskPath.cgPath
                genreOptionsMenu.layer.mask = shape

                UIView.animate(
                    withDuration: 0.5,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        self.fadeBackgroundView.alpha = 0.4
                        self.genreOptionsMenu.center.x += self.genreOptionsMenu.bounds.width
                },
                    completion: nil)
            }
        
        }
    }
                
    @objc private func dismissOptionsToRight(sender: UISwipeGestureRecognizer) {
        if genreOptionsMenu.leftSideSelectedGenres.count != 0 {
            // If we have 1 or more items in selection we are allowed to dismiss
            
            User.leftUser.selectedGenres.removeAll() // make sure its empty before storing
            for genre in genreOptionsMenu.leftSideSelectedGenres {
                User.leftUser.selectedGenres.append(genre)
                print("Stored: \(genreOptionsMenu.leftSideSelectedGenres.count)")
            }
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.genreOptionsMenu.center.x += self.genreOptionsMenu.bounds.width
            },
                completion: nil)
        } else {
            print("LEFT side empty") // otherwise inform user in some way
        }
    }
    
    @objc private func dismissOptionsToLeft(sender: UISwipeGestureRecognizer) {
        if genreOptionsMenu.rightSideSelectedGenres.count != 0 {
            
            User.rightUser.selectedGenres.removeAll()
            for genre in genreOptionsMenu.rightSideSelectedGenres {
                User.rightUser.selectedGenres.append(genre)
                print("Stored: \(genreOptionsMenu.rightSideSelectedGenres.count)")
            }
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.fadeBackgroundView.alpha = 0
                    self.genreOptionsMenu.center.x -= self.genreOptionsMenu.bounds.width
            },
                completion: nil)
        } else {
            print("RIGHT side empty")
        }
    }
    
}



