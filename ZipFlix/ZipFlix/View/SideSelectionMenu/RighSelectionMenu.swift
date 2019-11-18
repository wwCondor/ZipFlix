//
//  RighSelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RightSelectionMenu: SelectionMenu {
            
    override var cellId: String {
        return super.cellId + "rightSelectionMenuId"
    }
    
    var rightSideHasSelectedGenres = false
    var rightSideHasSelectedPeople = false
    var rightSideHasSelectedRating = false
    
    var imageNames: [String] {
        var imageArray: [String] = [emptyBubbleImage, emptyBubbleImage, emptyBubbleImage]

        if rightSideHasSelectedGenres == false {
            imageArray[0] = emptyBubbleImage
        } else if rightSideHasSelectedGenres == true {
            imageArray[0] = selectedBubbleImage
        }
        if rightSideHasSelectedPeople == false {
            imageArray[1] = emptyBubbleImage
        } else if rightSideHasSelectedPeople == true {
            imageArray[1] = selectedBubbleImage
        }
        if rightSideHasSelectedRating == false {
            imageArray[2] = emptyBubbleImage
        } else if rightSideHasSelectedRating == true {
            imageArray[2] = selectedBubbleImage
        }
        return imageArray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .bottomLeft], radius: Constants.menuCornerRadius)
    }
}

extension RightSelectionMenu {
    
    // Sets up cell content
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectionMenu.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        let inset: CGFloat = -40
        
        var cellImage: UIImage {
            var image: UIImage = UIImage(named: imageNames[indexPath.item])!
            if modeSelected == .lightMode {
                image = UIImage(named: imageNames[indexPath.item])!
            } else if modeSelected == .darkMode {
                image = UIImage(named: imageNames[indexPath.item])!.alpha(0.5)
            }
            return image
        }

        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset - 20, right: inset)
        cell.imageView.image = cellImage.withAlignmentRectInsets(edgeInsets)

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Check if we have an internet connection
        if Reachability.checkReachable() == true {
            if indexPath.row == 0 {
                self.genreMenuManager.presentOptions(direction: .fromLeft)

                if rightSideHasSelectedGenres == false {
                    rightSideHasSelectedGenres = true
                    collectionView.reloadItems(at: [indexPath])
                }
                
            } else if indexPath.row == 1 {
                self.personMenuManager.presentOptions(direction: .fromLeft)

                if rightSideHasSelectedPeople == false {
                    rightSideHasSelectedPeople = true
                    collectionView.reloadItems(at: [indexPath])
                }
            } else if indexPath.row == 2 {
                self.ratingSliderManager.presentSlider(direction: .fromLeft)
                
                if rightSideHasSelectedRating == false {
                    rightSideHasSelectedRating = true
                    collectionView.reloadItems(at: [indexPath])
                }
            } else {
                print("Button not connected")
            }
            
        } else if Reachability.checkReachable() == false {
            print("Internet Connection not Available!") // MARK: Alert
        }
        
    }
}
