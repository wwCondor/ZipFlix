//
//  TopButtonBar.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class TopButtonBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor(named:Colors.objectBG.color)
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = 15
        
    }
    
}


