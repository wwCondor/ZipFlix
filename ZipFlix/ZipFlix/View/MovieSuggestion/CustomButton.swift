//
//  CustomButton.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// Base class for button that allows for a state toggle
class CustomButton: UIButton {
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        addObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        addObservers()
    }
    
    func setupButton() { }
    
    func addObservers() { }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
