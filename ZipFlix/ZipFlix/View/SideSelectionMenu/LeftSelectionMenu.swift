//
//  LeftSelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class LeftSelectionMenu: SelectionMenu {
    
    let selectionManager = SelectionViewManager()
        
    let cellId = "leftSelectionMenuId"
    
    let emptyBubbleImage = Icons.bubbleEmpty.image
    let selectedBubbleImage = Icons.bubbleSelected.image
    
    lazy var imageNames = { [emptyBubbleImage, emptyBubbleImage, emptyBubbleImage] }()
    
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
    
    override func setupView() {
        backgroundColor = UIColor(named:Colors.sideMenuView.color)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectionMenu)
        selectionMenu.isScrollEnabled = false
    }
    
    override func setupConstraints() {
        let padding = 10
        
        addConstraintsWithFormat("H:|[v0]|", views: selectionMenu)
        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: selectionMenu)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topRight, .bottomRight], radius: Constants.menuCornerRadius)
    }
}

extension LeftSelectionMenu: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Sets the amount of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // Sets up cell content
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectionMenu.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let inset: CGFloat = -40
        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset - 20, right: inset)
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])!.withAlignmentRectInsets(edgeInsets)

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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            selectionManager.presentOptions(direction: .fromRight)
            print("Launch 1st menu")
        } else if indexPath.row == 1 {
            print("Launch 2nd menu")
        } else if indexPath.row == 2 {
            print("Launch 3rd menu")
        } else if indexPath.row == 3 {
            print("Launch 4th menu")
        } else {
            print("Launch 5th menu")
        }
    }
}

class SelectionMenu: UIView {
 
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
        
    }
    
    func setupConstraints() {
        
    }
}
