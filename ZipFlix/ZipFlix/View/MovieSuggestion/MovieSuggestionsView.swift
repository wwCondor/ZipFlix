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

class ContentView: UIView {
    
    lazy var posterView: UIImageView = {
        let image = UIImage(named: Icons.poster.image)
        let poster = UIImageView(image: image)
        poster.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
//        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.contentMode = .scaleAspectFit
        return poster
    }()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var overviewView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 60)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
//        addSubview(posterView)
//        addSubview(titleView)
//        addSubview(infoView)
//        addSubview(overviewView)
    }
    
    func setupConstraints() {
//        addConstraintsWithFormat("H:|[v0]|", views: titleView)
//        addConstraintsWithFormat("H:|[v0]|", views: infoView)
//        addConstraintsWithFormat("H:|[v0]|", views: overviewView)
//
//        addConstraintsWithFormat("V:|[v0][v1][v2]|", views: titleView, infoView, overviewView)
    }
    
    
}
