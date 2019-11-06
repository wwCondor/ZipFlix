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
        
        let zipDistance = leftZipperFour.bounds.width * (3/4) - 12
        
        let zipDuration: TimeInterval = 0.5
        let zipDelay: TimeInterval = -0.2
        
        if zipperState == .open {
            print("Closing Zipper")
            clearInputButton.isEnabled = false // to prevent starting open zipper animation during animation
            zipperState = .closed
            UIView.animate(withDuration: zipDuration,
                           delay: 0.0,
                           options: [.curveEaseIn],
                           animations: {
                            self.leftZipperFour.center.x += zipDistance
                            self.rightZipperFour.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveLinear],
                           animations: {
                            self.leftZipperThree.center.x += zipDistance
                            self.rightZipperThree.center.x -= zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveLinear],
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
                            self.animationCompleted()
                            self.clearInputButton.isEnabled = true
                       })
                   })
                })
            })
        } else {
            print("Zipper already closed")
        }
    }
    
    func openZipper() {
        
        let zipDistance = leftZipperFour.bounds.width * (3/4) - 12
        
        let zipDuration: TimeInterval = 0.4
        let zipDelay: TimeInterval = -0.2
        
        if zipperState == .closed {
            print("Opening Zipper")
            suggestMovieButton.isEnabled = false
            zipperState = .open
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
                           options: [.curveLinear],
                           animations: {
                            self.leftZipperTwo.center.x -= zipDistance
                            self.rightZipperTwo.center.x += zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveLinear],
                           animations: {
                            self.leftZipperThree.center.x -= zipDistance
                            self.rightZipperThree.center.x += zipDistance
            },
                           completion: { _ in
            UIView.animate(withDuration: zipDuration,
                           delay: zipDelay,
                           options: [.curveEaseOut],
                           animations: {
                            self.leftZipperFour.center.x -= zipDistance
                            self.rightZipperFour.center.x += zipDistance
            },
                           completion: { _ in
                            self.animationCompleted()
                            self.suggestMovieButton.isEnabled = true
                       })
                   })
                })
            })
        } else {
            print("Zipper already open")
        }
    }
    
    private func animationCompleted() {
        print("Done")
    }
}
