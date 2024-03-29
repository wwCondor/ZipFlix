//
//  RighSelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RightSelectionMenuLauncher: SelectionMenu {
            
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

extension RightSelectionMenuLauncher {
    
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if zipperIsAnimating == false {
            if APIKey.key == "" {
                print(MovieDBError.missingKey.description)
            } else {
                DispatchQueue.main.async {
                    let connectionAvailable = Reachability.checkReachable()
                    if connectionAvailable == true {
                        if indexPath.row == 0 {
                            self.genreMenuManager.presentOptions(direction: .fromLeft)
                            
                            if self.rightSideHasSelectedGenres == false {
                                self.rightSideHasSelectedGenres = true
                                collectionView.reloadItems(at: [indexPath])
                            }
                        } else if indexPath.row == 1 {
                            self.personMenuManager.presentOptions(direction: .fromLeft)
                            
                            if self.rightSideHasSelectedPeople == false {
                                self.rightSideHasSelectedPeople = true
                                collectionView.reloadItems(at: [indexPath])
                            }
                        } else if indexPath.row == 2 {
                            self.ratingSliderManager.presentSlider(direction: .fromLeft)
                            
                            if self.rightSideHasSelectedRating == false {
                                self.rightSideHasSelectedRating = true
                                collectionView.reloadItems(at: [indexPath])
                            }
                        } else {
                            print("Button not connected") // for possible additional future selection critera
                        }
                        
                    } else if connectionAvailable == false {
                        Alert.presentAlertFromNSObject(description: MovieDBError.noReachability.description)
                    }
                }
            }
        } else if zipperIsAnimating == true {
            print("Zipper is animating, selection menu disabled")
        }
    }
    
}
