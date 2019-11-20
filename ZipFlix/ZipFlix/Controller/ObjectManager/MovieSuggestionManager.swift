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
        return movieSuggestions
    }()
    
    lazy var touchScreen: UIView = {
        let touchscreen = UIView()
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
        swipeLeftGesture.direction = .left
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(navigateSuggestionsBySwipe(sender:)))
        swipeRightGesture.direction = .right
        touchscreen.addGestureRecognizer(swipeLeftGesture)
        touchscreen.addGestureRecognizer(swipeRightGesture)
        touchscreen.backgroundColor = UIColor.clear
        return touchscreen
    }()
    
    lazy var posterView: UIImageView = {
        let image = UIImage(named: Icons.poster.image)?.withRenderingMode(.alwaysOriginal)
        let posterView = UIImageView(image: image)
        posterView.backgroundColor = UIColor.yellow
        return posterView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.text = "Slightly longer title than before"
        return label
    }()
    
    // Left side labels
    lazy var originalLanguageLabel: LeftSideLabel = {
        let label = LeftSideLabel()
        label.text = "Original Language"
        return label
    }()
    
    lazy var genreLabel: LeftSideLabel = {
        let label = LeftSideLabel()
        label.text = "Genre"
        return label
    }()
    
    lazy var averageVoteLabel: LeftSideLabel = {
        let label = LeftSideLabel()
        label.text = "Vote average"
        return label
    }()
    
    lazy var releaseDataLabel: LeftSideLabel = {
        let label = LeftSideLabel()
        label.text = "Release date"
        return label
    }()
    
    // Right side labels
    lazy var originalLanguageInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "en"
        return label
    }()

    lazy var genreInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "14"
        return label
    }()
    
    lazy var averageVoteInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "5.0"
        return label
    }()

    lazy var releaseDataInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "14.23.2134"
        return label
    }()
    
    // Overview
    lazy var movieOverview: UITextView = {
        let movieOverview = UITextView()
        movieOverview.text = "Some text about the movie. Likely the protagonist gets into a seemingly hopeless and messy situation. Although through wit or cleverness he/she endures and overcomes, likely picking up a girl/boy along the way and becomes the hero of the story"
        movieOverview.font!.withSize(15)
        movieOverview.textColor = UIColor.white
        movieOverview.backgroundColor = UIColor.clear
        movieOverview.isEditable = false
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        return movieOverview
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
            
            window.addSubview(posterView)
            
            window.addSubview(titleLabel)
            window.addSubview(averageVoteLabel)
            window.addSubview(genreLabel)
            window.addSubview(originalLanguageLabel)
            window.addSubview(releaseDataLabel)
            
            window.addSubview(averageVoteInfoLabel)
            window.addSubview(genreInfoLabel)
            window.addSubview(originalLanguageInfoLabel)
            window.addSubview(releaseDataInfoLabel)
            
            window.addSubview(touchScreen)
            window.addSubview(movieOverview)

            fadeBackgroundView.frame = window.frame
            fadeBackgroundView.alpha = 0
            fadeBackgroundView.backgroundColor = UIColor.black
            fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSuggestions(sender:))))
            
            movieSuggestions.alpha = 0
            leftNavigator.alpha = 0
            rightNavigator.alpha = 0
            
            let windowWidth = window.frame.width
            let windowHeight = window.frame.height
            let movieSuggestionsWidth = windowWidth * (7.22/9)
            let movieSuggestionsHeigth = windowHeight * (5/7)
            let xOffset = (windowWidth - movieSuggestionsWidth) / 2
            let yOffset = windowHeight * 2.5/14
            movieSuggestions.frame = CGRect(x: xOffset, y: yOffset, width: movieSuggestionsWidth, height: movieSuggestionsHeigth)
            touchScreen.frame = CGRect(x: xOffset, y: yOffset, width: movieSuggestionsWidth, height: movieSuggestionsHeigth)
            
            let padding: CGFloat = 30
            let contentWidth = movieSuggestionsWidth - (2 * padding)
            
            let posterHeigth = contentWidth * 1.5
            let contentXOffset = xOffset + padding
            let posterYOffset = yOffset + padding
            posterView.frame = CGRect(x: contentXOffset, y: posterYOffset, width: contentWidth, height: posterHeigth)
            
            let restHeigth = movieSuggestionsHeigth - (2 * padding) - posterHeigth
            let labelHeigth = restHeigth / 10
            let spacing = labelHeigth / 5
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: spacing),
                titleLabel.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                titleLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                titleLabel.widthAnchor.constraint(equalToConstant: contentWidth),
                
                // Left side labels
                averageVoteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
                averageVoteLabel.trailingAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                averageVoteLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                averageVoteLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                genreLabel.topAnchor.constraint(equalTo: averageVoteLabel.bottomAnchor),
                genreLabel.trailingAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                genreLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                genreLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                originalLanguageLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
                originalLanguageLabel.trailingAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                originalLanguageLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                originalLanguageLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                releaseDataLabel.topAnchor.constraint(equalTo: originalLanguageLabel.bottomAnchor),
                releaseDataLabel.trailingAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                releaseDataLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                releaseDataLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                // Right side labels
                averageVoteInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spacing),
                averageVoteInfoLabel.leadingAnchor.constraint(equalTo: averageVoteLabel.trailingAnchor),
                averageVoteInfoLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                averageVoteInfoLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                genreInfoLabel.topAnchor.constraint(equalTo: averageVoteInfoLabel.bottomAnchor),
                genreInfoLabel.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor),
                genreInfoLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                genreInfoLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                originalLanguageInfoLabel.topAnchor.constraint(equalTo: genreInfoLabel.bottomAnchor),
                originalLanguageInfoLabel.leadingAnchor.constraint(equalTo: originalLanguageLabel.trailingAnchor),
                originalLanguageInfoLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                originalLanguageInfoLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                releaseDataInfoLabel.topAnchor.constraint(equalTo: originalLanguageInfoLabel.bottomAnchor),
                releaseDataInfoLabel.leadingAnchor.constraint(equalTo: releaseDataLabel.trailingAnchor),
                releaseDataInfoLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                releaseDataInfoLabel.widthAnchor.constraint(equalToConstant: contentWidth / 2),
                
                // Overview
                movieOverview.topAnchor.constraint(equalTo: releaseDataLabel.bottomAnchor, constant: 3 * spacing),
                movieOverview.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor, constant: 0),
                movieOverview.heightAnchor.constraint(equalToConstant: 4 * labelHeigth),
                movieOverview.widthAnchor.constraint(equalToConstant: contentWidth),
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
                    self.posterView.alpha = 1.0
                    self.titleLabel.alpha = 1.0

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
                self.posterView.alpha = 0
                self.titleLabel.alpha = 0

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

class MovieLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupAdditionalProperties()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProperties()
        setupAdditionalProperties()
    }

    // settings similar for all labels
    func setupProperties() {
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor.white
    }
    
    func setupAdditionalProperties() {
        
    }

}

class LeftSideLabel: MovieLabel {
    override func setupAdditionalProperties() {
        textAlignment = .left
        font = font.withSize(14)
    }
}

class RightSideLabel: MovieLabel {
    override func setupAdditionalProperties() {
        textAlignment = .right
        font = UIFont.boldSystemFont(ofSize: 14)
    }
}
