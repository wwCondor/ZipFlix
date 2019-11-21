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
    
    var currentMovie: Int = 0

    lazy var movieSuggestions: MovieSuggestionsView = {
        let movieSuggestions = MovieSuggestionsView()
        movieSuggestions.backgroundColor = UIColor(named: Colors.border.color)
        return movieSuggestions
    }()
    
    let selectedGenres: [Genre] = [Genre]()
    let selectedPersons: [Person] = [Person]()
    let selectedRatings: [Float] = [Float]()
    
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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return activityIndicator
    }()
    
    lazy var posterView: UIImageView = {
        let image = UIImage(named: Icons.noPoster.image)//
        let posterView = UIImageView(image: image)
        posterView.backgroundColor = UIColor.clear
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
        label.text = "-"
        return label
    }()

    lazy var genreInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "-"
        return label
    }()
    
    lazy var averageVoteInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "-"
        return label
    }()

    lazy var releaseDataInfoLabel: RightSideLabel = {
        let label = RightSideLabel()
        label.text = "-"
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
        
        let lightModeBG = UIColor(named: Colors.lmBackground.color)
        let darkModeBG = UIColor(named: Colors.dmBackground.color)
        movieSuggestions.contentView.backgroundColor = bool ? darkModeBG : lightModeBG
    }
    
    var allMovies: [Movie] = [Movie]()
    
    func discoverMovies() {
        MovieDataManager.discoverLeftMovies { (movies, error) in
            self.activityIndicator.startAnimating()
            DispatchQueue.main.async {
                guard let movies = movies else {
                    print("Left side gave no results")
                    return
                }
                for movie in movies {
                    if !self.allMovies.contains(movie) {
                        self.allMovies.append(movie)
                    }
                }
                
                print(self.allMovies.count)
                
                self.setUpLabels(for: self.currentMovie)
                self.activityIndicator.stopAnimating()

            }
        }
        
        MovieDataManager.discoverRightMovies { (movies, error) in
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            guard let movies = movies else {
                print("Right side gave no results")
                return
            }
            
            for movie in movies {
                if !self.allMovies.contains(movie) {
                    self.allMovies.append(movie)
                }
            }
            
            print(self.allMovies.count)
            
            self.activityIndicator.stopAnimating()
            }
        }
    }

    func setUpLabels(for movie: Int) {
        if allMovies.count != 0 {
            
            guard let posterPath = allMovies[currentMovie].posterPath else {
                self.posterView.image = UIImage(named: Icons.noPoster.image)
                return
            }
            guard let title = allMovies[currentMovie].title else {
                self.titleLabel.text = "No results"
                return
            }
            guard let vote = allMovies[currentMovie].voteAverage else {
                self.averageVoteInfoLabel.text = "?"
                return
            }
            guard let genreIds = allMovies[currentMovie].genreIds else {
                self.genreInfoLabel.text = "?"
                return
            }
            guard let language = allMovies[currentMovie].originalLanguage else {
                self.originalLanguageInfoLabel.text = "?"
                return
            }
            guard let date = allMovies[currentMovie].releaseDate else {
                self.releaseDataInfoLabel.text = "?"
                return
            }
            guard let movieDiscription = allMovies[currentMovie].overview else {
                self.movieOverview.text = "The selections made have not resulted in any"
                return
            }
            print(posterPath)
//            let url = URL(string: posterPath, relativeTo: PosterImageHandler.imageBaseURl)!
//            PosterImageHandler.getData(from: url) { data, response, error in
//                guard let data = data, error == nil else { return }
//                DispatchQueue.main.async() {
//                    self.posterView.image = UIImage(data: data)
//                }
//            }
            
            posterView.downloaded(from: posterPath, contentMode: .scaleAspectFit)
            titleLabel.text = "\(title)"
            averageVoteInfoLabel.text = "\(vote)"
            let genreNames = getGenreNames(for: genreIds) // MARK: Does not work?
            genreInfoLabel.text = "\(genreNames)"
            originalLanguageInfoLabel.text = "\(language)"
            releaseDataInfoLabel.text = "\(date)"
            movieOverview.text = "\(movieDiscription)"
        } else {
            print("We have no results")
        }
    }
    
    func getGenreNames(for ids: [Int]) -> [String] {
        var genreNames: [String] = []
        let genres = selectedGenres
        
        if genres.count != 0 {
            for id in ids {
                for genre in genres {
                    guard let genreId = genre.id, let genreName = genre.name else {
                        print("Hmmmm")
                        return ["Woops"]
                    }
                    if genreId == id {
                        genreNames.append(genreName)
                    } else {
                        genreNames.append("")
                    }
                }
            }
        } else {
            return genreNames
        }
        return genreNames
    }
        
    func presentSuggestions() {
        discoverMovies()
         
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
            
            window.addSubview(activityIndicator)
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
                activityIndicator.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: movieSuggestions.centerYAnchor),
                
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
                    self.averageVoteLabel.alpha = 1.0
                    self.averageVoteInfoLabel.alpha = 1.0
                    self.genreLabel.alpha = 1.0
                    self.genreInfoLabel.alpha = 1.0
                    self.originalLanguageLabel.alpha = 1.0
                    self.originalLanguageInfoLabel.alpha = 1.0
                    self.releaseDataLabel.alpha = 1.0
                    self.releaseDataInfoLabel.alpha = 1.0
                    self.movieOverview.alpha = 1.0
                    self.activityIndicator.alpha = 1.0
                    self.touchScreen.alpha = 1.0
            },
                completion: nil)
        }
    }
        
    @objc private func dismissSuggestions(sender: UISwipeGestureRecognizer) {
        allMovies.removeAll()
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
                self.averageVoteLabel.alpha = 0
                self.averageVoteInfoLabel.alpha = 0
                self.genreLabel.alpha = 0
                self.genreInfoLabel.alpha = 0
                self.originalLanguageLabel.alpha = 0
                self.originalLanguageInfoLabel.alpha = 0
                self.releaseDataLabel.alpha = 0
                self.releaseDataInfoLabel.alpha = 0
                self.movieOverview.alpha = 0
                self.activityIndicator.alpha = 0
                self.touchScreen.alpha = 0
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
        if allMovies.count != 0 {
            if currentMovie > 0 {
                currentMovie -= 1
                setUpLabels(for: currentMovie)
            } else if currentMovie == 0 {
                currentMovie = allMovies.count - 1
                setUpLabels(for: currentMovie)
            }
        } else {
            print("we have no results")
        }
        print("Movie number: \(currentMovie)/\(allMovies.count - 1)")

    }
    
    @objc func showNextSuggestion() {
        if allMovies.count != 0 {
            if currentMovie != allMovies.count - 1 {
                currentMovie += 1
                setUpLabels(for: currentMovie)
            } else {
                currentMovie = 0
                setUpLabels(for: currentMovie)
            }
        } else {
            print("we have no results")
        }
        print("Movie number: \(currentMovie)/\(allMovies.count - 1)")
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
