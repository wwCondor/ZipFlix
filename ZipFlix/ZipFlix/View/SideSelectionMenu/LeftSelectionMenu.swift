//
//  LeftSelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class LeftSelectionMenu: SelectionMenu {
    
    override var cellId: String {
        return super.cellId + "leftSelectionMenuId"
    }
    
    var leftSideHasSelectedGenres = false
    var leftSideHasSelectedPeople = false
    var leftSideHasSelectedRating = false
        
    var imageNames: [String] {
        var imageArray: [String] = [emptyBubbleImage, emptyBubbleImage, emptyBubbleImage]

        if leftSideHasSelectedGenres == false {
            imageArray[0] = emptyBubbleImage
        } else if leftSideHasSelectedGenres == true {
            imageArray[0] = selectedBubbleImage
        }
        if leftSideHasSelectedPeople == false {
            imageArray[1] = emptyBubbleImage
        } else if leftSideHasSelectedPeople == true {
            imageArray[1] = selectedBubbleImage
        }
        if leftSideHasSelectedRating == false {
            imageArray[2] = emptyBubbleImage
        } else if leftSideHasSelectedRating == true {
            imageArray[2] = selectedBubbleImage
        }
        return imageArray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topRight, .bottomRight], radius: Constants.menuCornerRadius)
    }
}

extension LeftSelectionMenu { 
    
    // Sets up cell content
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectionMenu.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BubbleCell
        let inset: CGFloat = -40
        
        var cellImage: UIImage {
            var image: UIImage = UIImage(named: imageNames[indexPath.item])!
            if modeSelected == .lightMode {
                image = UIImage(named: imageNames[indexPath.item])!
            } else if modeSelected == .darkMode {
                image = UIImage(named: imageNames[indexPath.item])!.alpha(Constants.dimAlpha)
            }
            return image
        }

        let edgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset - 20, right: inset)
        cell.imageView.image = cellImage.withAlignmentRectInsets(edgeInsets)

        return cell
    }
    
    // Sets up what to do when a cell gets tapped
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if zipperIsAnimating == false {
            if APIKey.key == "" {
                print(MovieDBError.missingKey.description) // Only used during development/peer reviews
            } else {
                let connectionAvailable = Reachability.checkReachable()
                // Check if we have an internet connection
                if connectionAvailable == true {
                    if indexPath.row == 0 {
                        self.genreMenuManager.presentOptions(direction: .fromRight)

                        if leftSideHasSelectedGenres == false {
                            leftSideHasSelectedGenres = true
                            collectionView.reloadItems(at: [indexPath])
                        }
                        
                    } else if indexPath.row == 1 {
                        self.personMenuManager.presentOptions(direction: .fromRight)

                        if leftSideHasSelectedPeople == false {
                            leftSideHasSelectedPeople = true
                            collectionView.reloadItems(at: [indexPath])
                        }
                    } else if indexPath.row == 2 {
                        self.ratingSliderManager.presentSlider(direction: .fromRight)
                        
                        if leftSideHasSelectedRating == false {
                            leftSideHasSelectedRating = true
                            collectionView.reloadItems(at: [indexPath])
                        }
                    } else {
                        print("Button not connected") // for possible additional future selection critera
                    }
                    
                } else if connectionAvailable == false {
                    Alert.presentAlertFromNSObject(description: MovieDBError.noReachability.description)
                }
            }
        } else if zipperIsAnimating == true {
            print("Zipper is animating, selection menu disabled")
        }
        
    }
}


 
