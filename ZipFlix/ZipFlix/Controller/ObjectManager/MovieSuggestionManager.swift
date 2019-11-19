//
//  SuggestionsManager .swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 09/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MovieSuggestionManager: ObjectManager {
    
    let clearInputNotification = Notification.Name(rawValue: Constants.clearInputNotificationKey)
    
    var movies: [TestMovie] = [TestMovie]()

        
    lazy var movieSuggestions: MovieSuggestionsView = {
        let movieSuggestions = MovieSuggestionsView()
        movieSuggestions.backgroundColor = UIColor(named: Colors.border.color)
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
        swipeRightGesture.direction = .right
        movieSuggestions.addGestureRecognizer(swipeLeftGesture)
        movieSuggestions.addGestureRecognizer(swipeRightGesture)
        return movieSuggestions
    }()
    
    lazy var posterView: UIImageView = {
        let image = UIImage(named: Icons.poster.image)
        let poster = UIImageView(image: image)
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.contentMode = .scaleAspectFit
        return poster
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Title"
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some text about the movie. Likely the protagonist gets into a seemingly hopeless and messy situation. Although through wit or cleverness he/she endures and overcomes, likely picking up a girl/boy along the way and becomes the hero of the story"
        label.font.withSize(14)
        label.numberOfLines = 5
        return label
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
    
    override func activateButton(bool: Bool) {
        isOn = bool
        
        let lightMode = UIColor(named: Colors.lmBackground.color)
        let darkMode = UIColor(named: Colors.dmBackground.color)
        movieSuggestions.contentView.backgroundColor = bool ? darkMode : lightMode
    }
    
    func createTestContent() {
        movies.append(TestMovie(posterPath: Icons.poster.image, originalLanguage: "en", genreIds: [1, 1, 1], title: "a", voteAverage: 1.1, overview: "1", releaseDate: "2014-11-14"))
        movies.append(TestMovie(posterPath: Icons.poster.image, originalLanguage: "en", genreIds: [2, 2, 2], title: "b", voteAverage: 2.2, overview: "2", releaseDate: "2014-11-14"))
        movies.append(TestMovie(posterPath: Icons.poster.image, originalLanguage: "en", genreIds: [3, 3, 3], title: "c", voteAverage: 3.3, overview: "3", releaseDate: "2014-11-14"))
    }
        
    func presentSuggestions() {
        createTestContent()
         
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
            
            let movieSuggestionsWidth = window.frame.width * (7/9)
            let movieSuggestionsHeigth = window.frame.height * (5/7)
            let xOffset = window.frame.width * 1/9
            let yOffset = window.frame.height * 2.5/14
            movieSuggestions.frame = CGRect(x: xOffset, y: yOffset, width: movieSuggestionsWidth, height: movieSuggestionsHeigth)
            
            let contentWidth = movieSuggestionsWidth - 60
            
//            movieSuggestions.addSubview(posterView)
            movieSuggestions.addSubview(titleLabel)
            movieSuggestions.addSubview(overviewLabel)
            
            NSLayoutConstraint.activate([
//                posterView.topAnchor.constraint(equalTo: movieSuggestions.topAnchor, constant: 0),
//                posterView.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor, constant: 0),
//                posterView.widthAnchor.constraint(equalToConstant: contentWidth),
                
                titleLabel.bottomAnchor.constraint(equalTo: overviewLabel.topAnchor, constant: 15),
                titleLabel.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor, constant: 0),
                titleLabel.heightAnchor.constraint(equalToConstant: 15),
                titleLabel.widthAnchor.constraint(equalToConstant: contentWidth),
                
                overviewLabel.bottomAnchor.constraint(equalTo: movieSuggestions.bottomAnchor, constant: 30),
                overviewLabel.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor, constant: 0),
                overviewLabel.heightAnchor.constraint(equalToConstant: 120),
                overviewLabel.widthAnchor.constraint(equalToConstant: contentWidth)


            ])
            
            let indicatorSize = movieSuggestionsWidth / 4
            let offset: CGFloat = 2

            leftNavigator.backgroundColor = .clear
            rightNavigator.backgroundColor = .clear
            
            NSLayoutConstraint.activate([
                leftNavigator.heightAnchor.constraint(equalToConstant: indicatorSize),
                leftNavigator.widthAnchor.constraint(equalToConstant: indicatorSize / 2),
                leftNavigator.trailingAnchor.constraint(equalTo: movieSuggestions.leadingAnchor, constant: offset),
                leftNavigator.centerYAnchor.constraint(equalTo: movieSuggestions.centerYAnchor),
                
                rightNavigator.heightAnchor.constraint(equalToConstant: indicatorSize),
                rightNavigator.widthAnchor.constraint(equalToConstant: indicatorSize / 2),
                rightNavigator.leadingAnchor.constraint(equalTo: movieSuggestions.trailingAnchor, constant: -offset),
                rightNavigator.centerYAnchor.constraint(equalTo: movieSuggestions.centerYAnchor)
            ])

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
            completion: { _ in
                NotificationCenter.default.post(name: self.clearInputNotification, object: nil) // Resets selections and slider. Opens Zipper
              })

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

