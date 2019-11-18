//
//  LeftMenuCell.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 07/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class BubbleCell: BaseCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        backgroundColor = UIColor(named: Colors.objectBG.color)
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {}
    
}
