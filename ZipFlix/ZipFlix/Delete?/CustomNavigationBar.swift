//
//  CustomNavigationBar.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    
    var modeSelected: ModeSelected = .lightMode
    let viewController = ViewController()
    
    lazy var modeSelectionButton: UIButton = {
            let modeSelectionButton = UIButton(type: .custom)
            modeSelectionButton.backgroundColor = UIColor.clear
            let iconImage = UIImage(named: Icons.lightModeIcon.image)!
            modeSelectionButton.setImage(iconImage, for: .normal)
            let inset: CGFloat = 8
            modeSelectionButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            modeSelectionButton.frame = CGRect(x: 0, y: 0, width: iconImage.size.width, height: iconImage.size.height) // Actually not needed?
            modeSelectionButton.imageView?.contentMode = .scaleAspectFit
            modeSelectionButton.addTarget(self, action: #selector(switchMode), for: .touchUpInside)
            return modeSelectionButton
        }()
        
        lazy var clearInputButton: UIButton = {
            let clearInputButton = UIButton(type: .custom)
            clearInputButton.backgroundColor = UIColor.clear
            let iconImage = UIImage(named: Icons.reset.image)!.withRenderingMode(.alwaysTemplate)
            clearInputButton.setImage(iconImage, for: .normal)
            clearInputButton.tintColor = UIColor.white
            let inset: CGFloat = 8
            clearInputButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset , bottom: inset, right: inset)
            clearInputButton.frame = CGRect(x: 0, y: 0, width: iconImage.size.width, height: iconImage.size.height) // Actually not needed?
            clearInputButton.imageView?.contentMode = .scaleAspectFit
            clearInputButton.addTarget(self, action: #selector(clearInput), for: .touchUpInside)
            return clearInputButton
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutSubviews()
        
        self.isTranslucent = true
        
        if modeSelected == .lightMode {
            self.backgroundColor = UIColor(named: Colors.lmNavBar.color)
        } else if modeSelected == .darkMode {
            self.backgroundColor = UIColor(named: Colors.dmNavBar.color)
        }

    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//
//    }

    override func layoutSubviews() {
        
        
        addSubview(modeSelectionButton)
        addSubview(clearInputButton)
        
        modeSelectionButton.backgroundColor = UIColor.systemRed
        clearInputButton.backgroundColor = UIColor.systemRed
        
//        let padding: CGFloat = 10
        
        addConstraintsWithFormat("H:|[v0][v1]|", views: clearInputButton, modeSelectionButton)
        addConstraintsWithFormat("V:|[v0]|", views: clearInputButton)
        addConstraintsWithFormat("V:|[v0]|", views: modeSelectionButton)
        
    }
    
    @objc func switchMode(sender: UIBarButtonItem) {
        if modeSelected == .darkMode {
            modeSelected = .lightMode
            let modeIconImage = UIImage(named: Icons.lightModeIcon.image)//!.withRenderingMode(.alwaysTemplate)
            modeSelectionButton.setImage(modeIconImage, for: .normal)
            modeSelectionButton.backgroundColor = UIColor.systemRed
            clearInputButton.backgroundColor = UIColor.systemRed
            clearInputButton.tintColor = UIColor.white
//            viewController.view.backgroundColor = UIColor(named: Colors.lmBackground.color)
            
        } else if modeSelected == .lightMode {
            modeSelected = .darkMode
            let modeIconImage = UIImage(named: Icons.darkModeIcon.image)!.withRenderingMode(.alwaysTemplate)
            modeSelectionButton.setImage(modeIconImage, for: .normal)
            modeSelectionButton.backgroundColor = UIColor(named: Colors.dmNavBar.color)
            clearInputButton.backgroundColor = UIColor(named: Colors.dmNavBar.color)
            modeSelectionButton.tintColor = UIColor.black
            clearInputButton.tintColor = UIColor.black
//            viewController.view.backgroundColor = UIColor(named: Colors.dmBackground.color)
        }
    }
    
    @objc func clearInput(sender: UIBarButtonItem) {
        print("Cleared Input")
    }

}
