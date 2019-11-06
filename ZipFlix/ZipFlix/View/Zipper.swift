//
//  CustomShapeView.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 06/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class LeftSideZipper: Zipper {
    
    override func draw(_ rect: CGRect) {
        let width = self.bounds.size.width
        let widthOffset = width / 4
        let height = self.bounds.size.height
        let heightPart = height / 8
        
        let p1 = self.bounds.origin
        let p2 = CGPoint(x: width, y: 0)
        let p3 = CGPoint(x: width, y: 2 * heightPart)
        
        let p4 = CGPoint(x: width - widthOffset, y: 3 * heightPart)
        let p5 = CGPoint(x: width - widthOffset, y: 5 * heightPart)
        let p6 = CGPoint(x: width, y: 6 * heightPart)
        let p7 = CGPoint(x: width, y: height)
        
        let p8 = CGPoint(x: 0, y: height)

        let path = UIBezierPath()

        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addLine(to: p6)
        path.addLine(to: p7)
        path.addLine(to: p8)
        path.close()
        
//        zipperBorderColor.setStroke()
//        path.lineWidth = 5
//        path.stroke()

        zipperColor.setFill()
        path.fill()

//        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = path.cgPath
//        self.layer.mask = shapeLayer

    }
}


class RigthSideZipper: Zipper {
    
    override func draw(_ rect: CGRect) {
        let width = self.bounds.size.width
        let widthOffset = width / 4
        let height = self.bounds.size.height
        let heightPart = height / 8
        
        let p1 = CGPoint(x: widthOffset, y: 0)
        let p2 = CGPoint(x: width, y: 0)
        let p3 = CGPoint(x: width, y: height)
        
        let p4 = CGPoint(x: widthOffset, y: height)
        let p5 = CGPoint(x: widthOffset, y: 6 * heightPart)
        let p6 = CGPoint(x: 0, y: 5 * heightPart)
        let p7 = CGPoint(x: 0, y: 3 * heightPart)
        
        let p8 = CGPoint(x: widthOffset, y: 2 * heightPart)

        let path = UIBezierPath()

        zipperColor.setFill()

        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.addLine(to: p5)
        path.addLine(to: p6)
        path.addLine(to: p7)
        path.addLine(to: p8)
        path.close()
        path.fill()

    }
}


class Zipper: UIView {
    
    var zipperColor = UIColor(named: Colors.zipper.color)! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var isOn = false
    
    let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
    let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)
    
//    let zipperColor = UIColor(named: Colors.zipper.color)!
//    let zipperBorderColor = UIColor(named: Colors.zipperBorder.color)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        setupView()
    }
    
    func setupView() {
//        addObservers()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = 15
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
        
        // In here we do something if darkmode is selected
        
//        let fillColor = UIColor(named: Colors.zipper.color)?.setFill()


        
        // Changes alpha when dark mode is selected
//        let lightModeIcon = UIImage(named: Icons.movieIcon.image)?.withRenderingMode(.alwaysOriginal)
//        let darkModeIcon = UIImage(named: Icons.movieIcon.image)!.alpha(0.5)
//        let image = bool ? darkModeIcon : lightModeIcon
//        setImage(image, for: .normal)
    }
}
