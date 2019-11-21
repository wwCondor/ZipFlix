//
//  MovieSuggestions.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 10/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MovieSuggestionsView: UIView {
        
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(named: Colors.lmBackground.color)
        return contentView
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        layer.masksToBounds = false
        layer.cornerRadius = Constants.menuCornerRadius                
        addSubview(contentView)
    }
    
    func setupConstraints() {
        
        let padding = 15
        
        addConstraintsWithFormat("H:|-\(padding)-[v0]-\(padding)-|", views: contentView)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: contentView)
    }
    
    func getMovies() {
        print("Downloading movies")
    }
}
