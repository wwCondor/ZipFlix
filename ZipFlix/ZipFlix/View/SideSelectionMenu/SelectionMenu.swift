//
//  SelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SelectionMenu: UIView {
    
    let genreMenuManager = GenreMenuManager()
    let personMenuManager = PersonMenuManager()
    let ratingSliderManager = RatingSliderManager()
    
    let emptyBubbleImage = Icons.bubbleEmpty.image
    let selectedBubbleImage = Icons.bubbleSelected.image
    
    var modeSelected: ModeSelected = .lightMode
    
    var cellId: String {
        return ""
    }
    
    lazy var selectionMenu: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let selectionMenu = UICollectionView(frame: .zero, collectionViewLayout: layout)
        selectionMenu.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        selectionMenu.dataSource = self
        selectionMenu.delegate = self
        return selectionMenu
    }()
 
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
  
    func setupView() {
        backgroundColor = UIColor(named:Colors.objectBG.color)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectionMenu)
        selectionMenu.isScrollEnabled = false
    }
    
    func setupConstraints() {
        let padding = 10
        
        addConstraintsWithFormat("H:|[v0]|", views: selectionMenu)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: selectionMenu)
    }
}

extension SelectionMenu: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Sets the amount of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // Sets up cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectionMenu.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as! MenuCell
        return cell
    }
    
    // Sets up size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height / 3)
    }
    
    // Sets up spacing between posts
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Sets up what to do when a cell gets tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}
