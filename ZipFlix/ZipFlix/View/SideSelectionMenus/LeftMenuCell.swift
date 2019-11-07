//
//  LeftMenuCell.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 07/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class LeftMenuCell: BaseCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        backgroundColor = UIColor.systemPink
//        backgroundColor = UIColor(named: Colors.sideMenuView.color)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(imageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}
