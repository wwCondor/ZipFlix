//
//  ZipperAnimations.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 06/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

extension ViewController {
    
    func closeZipper() {
        let dimmerNotification = Notification.Name(rawValue: Constants.dimNotificationKey)
        let zipperNotification = Notification.Name(rawValue: Constants.zipperNotificationKey)
        
        let zipDistance = leftZipperFour.bounds.width * (3/4) - 12
        let zipDuration: TimeInterval = 0.20
        let zipDelay: TimeInterval = -0.2
        
        if zipperState == .open {
//            print("Closing Zipper")
            NotificationCenter.default.post(name: zipperNotification, object: nil)
            NotificationCenter.default.post(name: dimmerNotification, object: nil)
            clearInputButton.isEnabled = false // prevents starting open zipper animation during animation
            modeToggleButton.isEnabled = false // prevents switching modes during animation (and thereby resetting animation)
            zipperState = .closed
            UIView.animate(withDuration: zipDuration,
                           delay: 0.0,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperSix.center.x += zipDistance
                            self.rightZipperSix.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperFive.center.x += zipDistance
                            self.rightZipperFive.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperFour.center.x += zipDistance
                            self.rightZipperFour.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperThree.center.x += zipDistance
                            self.rightZipperThree.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperTwo.center.x += zipDistance
                            self.rightZipperTwo.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseOut],
                           animations: {
                            self.leftZipperOne.center.x += zipDistance
                            self.rightZipperOne.center.x -= zipDistance
            },
                           completion: { _ in
                            self.openZipperAnimationCompleted()
                            self.clearInputButton.isEnabled = true
                            NotificationCenter.default.post(name: zipperNotification, object: nil)
                                })
                            })
                        })
                   })
                })
            })
        } else {
            print("Zipper already closed")
        }
    }
    
    @objc func openZipper(sender: Notification) {
        let cancelDimmerNotification = Notification.Name(rawValue: Constants.cancelDimNotificationKey)
        let zipperNotification = Notification.Name(rawValue: Constants.zipperNotificationKey)

        let zipDistance = leftZipperFour.bounds.width * (3/4) - 12
        let zipDuration: TimeInterval = 0.20
        let zipDelay: TimeInterval = -0.2
        
        if zipperState == .closed {
//            print("Opening Zipper")
            suggestMovieButton.isEnabled = false
            zipperState = .open
            NotificationCenter.default.post(name: zipperNotification, object: nil)
            UIView.animate(withDuration: zipDuration,
                           delay: 0.0,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperOne.center.x -= zipDistance
                            self.rightZipperOne.center.x += zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperTwo.center.x -= zipDistance
                            self.rightZipperTwo.center.x += zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperThree.center.x -= zipDistance
                            self.rightZipperThree.center.x += zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperFour.center.x -= zipDistance
                            self.rightZipperFour.center.x += zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperFive.center.x -= zipDistance
                            self.rightZipperFive.center.x += zipDistance
            },
                            completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseOut],
                           animations: {
                            self.leftZipperSix.center.x -= zipDistance
                            self.rightZipperSix.center.x += zipDistance
            },
                             completion: { _ in
                            self.closeZipperAnimationCompleted()
                            self.suggestMovieButton.isEnabled = true
                            self.modeToggleButton.isEnabled = true
                            NotificationCenter.default.post(name: cancelDimmerNotification, object: nil)
                            NotificationCenter.default.post(name: zipperNotification, object: nil)
                              })
                           })
                       })
                   })
                })
            })
        } else {
            print("Zipper already open")
        }
    }
    
    private func openZipperAnimationCompleted() {
        if Reachability.checkReachable() == true {
            movieSuggestionsManager.presentSuggestions()
//            movieSuggestionsManager.makeDiscovery() 
        } else {
            closeZipper()
            Alert.presentAlert(description: MovieDBError.noReachability.description, viewController: self)
        }
    }
    
    private func closeZipperAnimationCompleted() {
        resetSelections()
    }
    
}
