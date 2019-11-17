//
//  RighSelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RightSelectionMenu: SelectionMenu {
            
    let cellId = "rightSelectionMenuId"
    
    var rigthSideHasSelectedGenres = false
        
    let emptyBubbleImage = Icons.bubbleEmpty.image
    let selectedBubbleImage = Icons.bubbleSelected.image
    
    var imageNames: [String] {
        var imageArray: [String] = [String]()

        if rigthSideHasSelectedGenres == false {
            imageArray = [emptyBubbleImage, emptyBubbleImage, emptyBubbleImage]
        } else if rigthSideHasSelectedGenres == true {
            imageArray = [selectedBubbleImage, emptyBubbleImage, emptyBubbleImage]
        }
        return imageArray
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
        roundCorners(corners: [.topLeft, .bottomLeft], radius: Constants.menuCornerRadius)
    }
}

extension RightSelectionMenu: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            GenreDataManager.fetchGenres { (genres, error) in
                DispatchQueue.main.async {
                    guard genres != nil else {
                        print("GenreError: Unable to obtain genres") // MARK: throw alert
                        return
                    }
                    self.genreMenuManager.presentOptions(direction: .fromLeft)
                }
            }
            if rigthSideHasSelectedGenres == false {
                rigthSideHasSelectedGenres = true
                collectionView.reloadItems(at: [indexPath])
            }
            
        } else if indexPath.row == 1 {
            print("Launch 2nd menu")
        } else {
            print("Launch 3th menu")
        }
    }
}
