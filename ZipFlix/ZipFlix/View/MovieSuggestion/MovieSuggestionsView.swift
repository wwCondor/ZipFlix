//
//  MovieSuggestions.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 10/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MovieSuggestionsView: UIView {
    
//    let scoreCellId = "cellId"
    
//    lazy var leftIndicator: LeftIndicator = {
//        let leftIndicator = LeftIndicator()
//        return leftIndicator
//    }()
//    
//    lazy var rightIndicator: RightIndicator = {
//        let rightIndicator = RightIndicator()
//        return rightIndicator
//    }()
    
//    lazy var scoreboard: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let scoreboard = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        scoreboard.register(ScoreboardCell.self, forCellWithReuseIdentifier: scoreCellId)
//        scoreboard.dataSource = self
//        scoreboard.delegate = self
//        scoreboard.layer.masksToBounds = true
//        return scoreboard
//    }()
    
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
//        addObservers()
        setupView()
        setupConstraints()
    }
    
    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        addObservers()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        layer.masksToBounds = false
        layer.cornerRadius = Constants.menuCornerRadius
        layer.borderColor = UIColor.gray.cgColor
        
//        addSubview(leftIndicator)
//        addSubview(rightIndicator)
    }
    
    func setupConstraints() {
        
//        let indicatorSize = frame.width / 8
////        let offSet: CGFloat = 5
//
//        leftIndicator.translatesAutoresizingMaskIntoConstraints = false
//        leftIndicator.heightAnchor.constraint(equalToConstant: indicatorSize).isActive = true
//        leftIndicator.widthAnchor.constraint(equalToConstant: indicatorSize / 2).isActive = true
////        leftIndicator.trailingAnchor.constraint(equalTo: leadingAnchor, constant: offSet).isActive = true
//        leftIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        leftIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
//        rightIndicator.translatesAutoresizingMaskIntoConstraints = false
//        rightIndicator.heightAnchor.constraint(equalToConstant: indicatorSize).isActive = true
//        rightIndicator.widthAnchor.constraint(equalToConstant: indicatorSize).isActive = true
//        rightIndicator.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -offSet).isActive = true
//        leftIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

//        let padding = 30
//
//        addConstraintsWithFormat("H:|[v0]|", views: scoreboard)
//        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: scoreboard)
    }
    
//    func addObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: lightModeNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(toggleState), name: darkModeNotification, object: nil)
//    }
//
//    @objc private func toggleState(notification: NSNotification) {
//        activateButton(bool: !isOn)
//    }
    
//    private func activateButton(bool: Bool) {
//        isOn = bool
//
//        // Change alpha when light/dark mode is enabled
//        let lightModeColor = UIColor(named: Colors.lmBackground.color)
//        let darkModeColor = UIColor(named: Colors.dmBackground.color)
//        backgroundColor = bool ? darkModeColor : lightModeColor
//    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
}
