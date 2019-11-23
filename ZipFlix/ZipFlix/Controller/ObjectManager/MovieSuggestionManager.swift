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
    
    var leftSideFinishedLoading: Bool = false
    var rightSideFinishedLoading: Bool = false
    
    var allGenres: [Genre] = [Genre]() // genres from TheMovieDB
    var allMovies: [Movie] = [Movie]() // discoveries
    var currentMovie: Int = 0

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
        
    private func discoverMovies() {
        self.allMovies.removeAll() // Make sure it is empty
        MovieDataManager.discoverLeftMovies { (movies, error) in
            self.activityIndicator.startAnimating()
            DispatchQueue.main.async {
                guard let movies = movies else {
                    self.leftSideFinishedLoading = true
                    return
                }
                for movie in movies {
                    if !self.allMovies.contains(movie) {
                        self.allMovies.append(movie)
                    }
                }
                self.activityIndicator.stopAnimating()
                self.leftSideFinishedLoading = true
                if self.leftSideFinishedLoading == true && self.rightSideFinishedLoading == true {
                    self.filterNilMovies() // filter rare 'Nil'-cases
                    self.allMovies.shuffle() // preventing discoveries to be ordered by actor
                    self.setLabels(for: self.currentMovie) // Whichever completes last triggers setupLabels
                    self.setPosterImage(for: self.currentMovie)
                    print("All movies: \(self.allMovies), total \(self.allMovies.count)")
                }
            }
        }
        
        MovieDataManager.discoverRightMovies { (movies, error) in
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                guard let movies = movies else {
                    self.rightSideFinishedLoading = true
                    return
                }
                
                for movie in movies {
                    if !self.allMovies.contains(movie) {
                        self.allMovies.append(movie)
                    }
                }
                self.activityIndicator.stopAnimating()
                self.rightSideFinishedLoading = true
                if self.leftSideFinishedLoading == true && self.rightSideFinishedLoading == true {
                    self.filterNilMovies()
                    self.allMovies.shuffle()
                    self.setLabels(for: self.currentMovie)
                    self.setPosterImage(for: self.currentMovie)
                    print("All movies: \(self.allMovies), total \(self.allMovies.count)")
                }
            }
        }
    }
    
    private func findIndex(for selected: Movie, in array: [Movie]) -> Int? {
        for (index, item) in array.enumerated() {
            if item == selected {
                return index
            }
        }
        return nil
    }
    
    private func filterNilMovies() {
        for movie in allMovies {
            if movie.title == nil || movie.posterPath == nil {
                guard let index = findIndex(for: movie, in: allMovies) else {
                    return
                }
                allMovies.remove(at: index)
            }
        }
    }
    
    private func fetchGenres() {
        GenreDataManager.fetchGenres { (genres, error) in
            DispatchQueue.main.async {
                guard let genres = genres else {
                    return
                }
                self.allGenres = genres
            }
        }
    }
    
    private func setPosterImage(for movie: Int) {
        let connectionPossible = Reachability.checkReachable()
        if connectionPossible == true {
            guard let posterPath = allMovies[currentMovie].posterPath else {
                return
            }
            posterView.downloaded(from: posterPath, contentMode: .scaleAspectFit)
        } else if connectionPossible == false {
            print("No connection. Could not obtain image yet")
            posterView.image = UIImage(named: Icons.noPoster.image)
        }
    }

    private func setLabels(for movie: Int) {
        if allMovies.count != 0 {
            let numberOfMovies = allMovies.count
            infoLabel.text = "\(currentMovie + 1) / \(numberOfMovies)"
            activityIndicator.startAnimating()

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
            titleLabel.text = "\(title)"
            averageVoteInfoLabel.text = "\(vote)"
            let genreNames = getGenreNames(for: genreIds)
            genreInfoLabel.text = "\(genreNames)"
            originalLanguageInfoLabel.text = "\(language)"
            releaseDataInfoLabel.text = "\(date)"
            movieOverview.text = "\(movieDiscription)"
            
            activityIndicator.stopAnimating()
        } else {
            infoLabel.text = "0 / 0"
            titleLabel.text = "No Results"
            averageVoteInfoLabel.text = ""
            genreInfoLabel.text = ""
            originalLanguageInfoLabel.text = ""
            releaseDataInfoLabel.text = ""
            movieOverview.text = "The selections you have made did not lead to a discovery. Please try again with different selections."
        }
    }
    
    // MARK: Convert Movie Genre IDs
    private func getGenreNames(for ids: [Int]) -> String {
        let genres = allGenres
        var genreArray = ""
        
        if genres.count != 0 {
                    for id in ids {
                        for genre in genres {
                            if id == genre.id! {
                                if genreArray == "" {
                                    genreArray.append("\(genre.name!)")

                                } else {
                                    genreArray.append(", \(genre.name!)")

                                }
                            }
                        }
                    }
        } else {
            return ""
        }
        return genreArray
    }

    func presentSuggestions() {
        currentMovie = 0
        fetchGenres()
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
            window.addSubview(infoLabel)
            window.addSubview(touchScreen)
            window.addSubview(movieOverview)

            fadeBackgroundView.frame = window.frame
            fadeBackgroundView.alpha = 0
            fadeBackgroundView.backgroundColor = UIColor.black
            fadeBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSuggestions(sender:))))
            
            infoLabel.backgroundColor = UIColor(named: Colors.border.color)
            
            movieSuggestions.alpha = 0
            leftNavigator.alpha = 0
            rightNavigator.alpha = 0
            
            let windowWidth = window.frame.width
            let windowHeight = window.frame.height
            let infoLabelSize = windowHeight / 14
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
                
                infoLabel.centerXAnchor.constraint(equalTo: movieSuggestions.centerXAnchor),
                infoLabel.widthAnchor.constraint(equalToConstant: infoLabelSize),
                infoLabel.heightAnchor.constraint(equalToConstant: infoLabelSize / 2 ),
                infoLabel.centerYAnchor.constraint(equalTo: movieSuggestions.topAnchor, constant: padding/4),
                
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
                genreLabel.trailingAnchor.constraint(equalTo: movieSuggestions.centerXAnchor, constant: -(contentWidth / 4)),
                genreLabel.heightAnchor.constraint(equalToConstant: labelHeigth),
                genreLabel.widthAnchor.constraint(equalToConstant: contentWidth * (1/4)),
                
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
                genreInfoLabel.widthAnchor.constraint(equalToConstant: contentWidth * (3/4)),
                
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
                    self.infoLabel.alpha = 1.0
            },
                completion: nil)
        }
    }
        
    @objc private func dismissSuggestions(sender: UISwipeGestureRecognizer) {
        allMovies.removeAll()
        leftSideFinishedLoading = false
        rightSideFinishedLoading = false
        posterView.image = UIImage(named: Icons.noPoster.image)
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
                self.infoLabel.alpha = 0
        },
            completion: { _ in
                NotificationCenter.default.post(name: self.clearInputNotification, object: nil) // Resets selections and slider. Opens Zipper
              })

    }
    
    @objc private func navigateSuggestionsBySwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
        }
        switch sender.direction {

        case .left: showNextSuggestion()
        case .right: showPreviousSuggestion()
        default:
            print("This does not work")
        }
    }
    
    // MARK: Navigation
    @objc private func showPreviousSuggestion() {
        if allMovies.count > 1 {
            if currentMovie != 0 {
                currentMovie -= 1
            } else {
                currentMovie = allMovies.count - 1
            }
            setLabels(for: currentMovie)
            setPosterImage(for: self.currentMovie)
        }
    }
    
    @objc private func showNextSuggestion() {
        if allMovies.count > 1 {
            if currentMovie != allMovies.count - 1 {
                currentMovie += 1
            } else {
                currentMovie = 0
            }
            setLabels(for: currentMovie)
            setPosterImage(for: self.currentMovie)
        }
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

    func setupProperties() {
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor.white
    }
    
    func setupAdditionalProperties() { }

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
