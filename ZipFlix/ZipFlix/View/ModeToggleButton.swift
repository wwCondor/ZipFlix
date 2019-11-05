//
//  CustomButtons.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ModeToggleButton: CustomButton {
    
    override func setupButton() {
        let image = UIImage(named: Icons.lightModeIcon.image)?.withRenderingMode(.alwaysOriginal)
        frame = CGRect(x: 0, y: 0, width: Constants.iconSize, height: Constants.iconSize)
        setImage(image, for: .normal)
        imageView?.contentMode = .scaleAspectFit
        contentMode = .center
        backgroundColor = .clear
        let inset: CGFloat = 7
        imageEdgeInsets = UIEdgeInsets(top: inset, left: inset + Constants.navBarIconOffset, bottom: inset + 2, right: inset)
        
        addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc private func buttonPressed(sender: UIButton) {
        activateButton(bool: !isOn)
    }
    
    private func activateButton(bool: Bool) {
        isOn = bool
        
        let lightModeIcon = UIImage(named: Icons.lightModeIcon.image)?.withRenderingMode(.alwaysOriginal)
        let darkModeIcon = UIImage(named: Icons.darkModeIcon.image)?.withRenderingMode(.alwaysTemplate)
        let image = bool ? darkModeIcon : lightModeIcon
        setImage(image, for: .normal)
        
        let darkModeTint = UIColor.black
        tintColor = bool ? darkModeTint : nil
    }
}


class CustomButton: UIButton {
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {

    }
}
  


