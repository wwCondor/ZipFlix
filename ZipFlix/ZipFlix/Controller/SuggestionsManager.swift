//
//  SuggestionsManager .swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 09/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class SuggestionsManager: NSObject {
        
    let fadeBackgroundView = UIView()
    
    var modeSelected: ModeSelected = .lightMode
    
    lazy var movieSuggestions: MovieSuggestionsView = {
        let movieSuggestions = MovieSuggestionsView()
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
        swipeRightGesture.direction = .right
        movieSuggestions.addGestureRecognizer(swipeLeftGesture)
        movieSuggestions.addGestureRecognizer(swipeRightGesture)
        return movieSuggestions
    }()
    
    lazy var leftNavigator: LeftNavigator = {
        let navigator = LeftNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPreviousSuggestion))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
    
    lazy var rightNavigator: RightNavigator = {
        let navigator = RightNavigator()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showNextSuggestion))
        navigator.addGestureRecognizer(tapGesture)
        return navigator
    }()
        
    func presentSuggestions() {
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            
            window.addSubview(fadeBackgroundView)
            
            window.addSubview(leftNavigator)
            window.addSubview(rightNavigator)
            
            window.addSubview(movieSuggestions)

            
            fadeBackgroundView.frame = window.frame
            fadeBackgroundView.alpha = 0
            fadeBackgroundView.backgroundColor = UIColor.black
            fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSuggestions(sender:))))
            
            movieSuggestions.alpha = 0
            leftNavigator.alpha = 0
            rightNavigator.alpha = 0

            
            if modeSelected == .lightMode {
                movieSuggestions.backgroundColor = UIColor(named: Colors.lmBackground.color)
            } else if modeSelected == .darkMode {
                movieSuggestions.backgroundColor = UIColor(named: Colors.dmBackground.color)
            }
            
            let movieSuggestionsWidth = window.frame.width * (7/9)
            let movieSuggestionsHeigth = window.frame.height * (5/7)
            let xOffset = window.frame.width * 1/9
            let yOffset = window.frame.height * 2.5/14
            movieSuggestions.frame = CGRect(x: xOffset, y: yOffset, width: movieSuggestionsWidth, height: movieSuggestionsHeigth)
            
            let indicatorSize = movieSuggestionsWidth / 4
            let offset: CGFloat = 2

            leftNavigator.backgroundColor = .clear
            leftNavigator.translatesAutoresizingMaskIntoConstraints = false
            leftNavigator.heightAnchor.constraint(equalToConstant: indicatorSize).isActive = true
            leftNavigator.widthAnchor.constraint(equalToConstant: indicatorSize / 2).isActive = true
            leftNavigator.trailingAnchor.constraint(equalTo: movieSuggestions.leadingAnchor, constant: offset).isActive = true
            leftNavigator.centerYAnchor.constraint(equalTo: movieSuggestions.centerYAnchor).isActive = true
            
            rightNavigator.backgroundColor = .clear
            rightNavigator.translatesAutoresizingMaskIntoConstraints = false
            rightNavigator.heightAnchor.constraint(equalToConstant: indicatorSize).isActive = true
            rightNavigator.widthAnchor.constraint(equalToConstant: indicatorSize / 2).isActive = true
            rightNavigator.leadingAnchor.constraint(equalTo: movieSuggestions.trailingAnchor, constant: -offset).isActive = true
            rightNavigator.centerYAnchor.constraint(equalTo: movieSuggestions.centerYAnchor).isActive = true
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.fadeBackgroundView.alpha = 0.4
                    self.movieSuggestions.alpha = 1.0
                    self.leftNavigator.alpha = 1.0
                    self.rightNavigator.alpha = 1.0

            },
                completion: nil)
        }
    }
        
    @objc private func dismissSuggestions(sender: UISwipeGestureRecognizer) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.fadeBackgroundView.alpha = 0
                self.movieSuggestions.alpha = 0
                self.leftNavigator.alpha = 0
                self.rightNavigator.alpha = 0
        },
            completion: nil)
            // When this gets dismissed it means user wants to restart movie suggestion process
            // - open zipper
            // - reset selection for user(s)
    }
    
    @objc func navigateSuggestionsBySwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
        }
        switch sender.direction {

        case .left: showNextSuggestion() // In here we should go to index + 1, e.g move right along suggestions array

        case .right: showPreviousSuggestion() // In here index - 1, e.g. move left along suggestions array
        default:
            print("This does not work")
        }
    }
    
    @objc func showPreviousSuggestion() {
        print("Showing previous suggestion")
    }
    
    @objc func showNextSuggestion() {
        print("Showing next suggestion")
    }
    
}





//extension Scoreboard: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//
//    // Number of cell per row
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    // Size of cell
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = scoreboard.frame.width * (3/4)
//        let cellHeigth = scoreboard.frame.height / 6
//        return CGSize(width: cellWidth, height: cellHeigth)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    // Content of cell
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = scoreboard.dequeueReusableCell(withReuseIdentifier: scoreCellId, for: indexPath) as! ScoreboardCell
//
//        return cell
//    }
//
//}
