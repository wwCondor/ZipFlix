////
////  Test.swift
////  ZipFlix
////
////  Created by Wouter Willebrands on 19/11/2019.
////  Copyright © 2019 Studio Willebrands. All rights reserved.
////
//
//import UIKit
//
//class Backup: UIView {
//    
//    var movies: [TestMovie] = [TestMovie]()
//    

//    
//    lazy var originalLanguageLabel: MovieLabel = {
//        let label = MovieLabel()
//        label.text = "Original Language"
//        return label
//    }()
//    
//    lazy var originalLanguageInfoLabel: MovieInfoLabel = {
//        let label = MovieInfoLabel()
//        label.text = "en"
//        return label
//    }()
//    
//    lazy var genreLabel: MovieLabel = {
//        let label = MovieLabel()
//        label.text = "Genre(s)"
//        return label
//    }()
//    
//    lazy var genreInfoLabel: MovieInfoLabel = {
//        let label = MovieInfoLabel()
//        label.text = "14"
//        return label
//    }()
//    

//    
//    lazy var averageVoteLabel: MovieLabel = {
//        let label = MovieLabel()
//        label.text = "Average Vote"
//        return label
//    }()
//    
//    lazy var averageVoteInfoLabel: MovieInfoLabel = {
//        let label = MovieInfoLabel()
//        label.text = "5.0"
//        return label
//    }()
//    

//    
//    lazy var releaseDataLabel: MovieLabel = {
//        let label = MovieLabel()
//        label.text = "Release Date"
//        return label
//    }()
//    
//    lazy var releaseDataInfoLabel: MovieInfoLabel = {
//        let label = MovieInfoLabel()
//        label.text = "14.23.2134"
//        return label
//    }()
//    
//    lazy var labelStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = NSLayoutConstraint.Axis.vertical
//        stack.distribution = UIStackView.Distribution.equalSpacing
//        stack.alignment = UIStackView.Alignment.leading
//        stack.spacing = 5
//        stack.backgroundColor = UIColor.systemRed
//        return stack
//    }()
//    
//    lazy var infoLabelStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = NSLayoutConstraint.Axis.vertical
//        stack.distribution = UIStackView.Distribution.equalSpacing
//        stack.alignment = UIStackView.Alignment.leading
//        stack.spacing = 5
//        stack.backgroundColor = UIColor.systemBlue
//        return stack
//    }()
//    
//    lazy var infoStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = NSLayoutConstraint.Axis.horizontal
//        stack.distribution = UIStackView.Distribution.equalSpacing
//        stack.alignment = UIStackView.Alignment.leading
//        stack.spacing = 5
//        stack.backgroundColor = UIColor.systemTeal
//        return stack
//    }()
//    
//    lazy var movieInfoStack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = NSLayoutConstraint.Axis.vertical
//        stack.distribution = UIStackView.Distribution.equalSpacing
//        stack.alignment = UIStackView.Alignment.leading
//        stack.spacing = 5
//        stack.backgroundColor = UIColor.systemBlue
//        return stack
//    }()
//    
////    let scoreCellId = "cellId"
//    
////    lazy var scoreboard: UICollectionView = {
////        let layout = UICollectionViewFlowLayout()
////        let scoreboard = UICollectionView(frame: .zero, collectionViewLayout: layout)
////        scoreboard.register(ScoreboardCell.self, forCellWithReuseIdentifier: scoreCellId)
////        scoreboard.dataSource = self
////        scoreboard.delegate = self
////        scoreboard.layer.masksToBounds = true
////        return scoreboard
////    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        createTestContent()
////        addObservers()
//        setupView()
//        setupConstraints()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
////        addObservers()
//        setupView()
//        setupConstraints()
//    }
//    
//    func createTestContent() {
//        movies.append(TestMovie(posterPath: Icons.poster.image, originalLanguage: "en", genreIds: [1, 1, 1], title: "a", voteAverage: 1.1, overview: "1", releaseDate: "2014-11-14"))
//        movies.append(TestMovie(posterPath: Icons.poster.image, originalLanguage: "en", genreIds: [2, 2, 2], title: "b", voteAverage: 2.2, overview: "2", releaseDate: "2014-11-14"))
//        movies.append(TestMovie(posterPath: Icons.poster.image, originalLanguage: "en", genreIds: [3, 3, 3], title: "c", voteAverage: 3.3, overview: "3", releaseDate: "2014-11-14"))
//    }
//    
//    func setupLabelStack() {
//        labelStack.addArrangedSubview(averageVoteLabel)
//        labelStack.addArrangedSubview(genreLabel)
//        labelStack.addArrangedSubview(originalLanguageLabel)
//        labelStack.addArrangedSubview(releaseDataLabel)
//        
//        addConstraintsWithFormat("H:|[v0(50)]|", views: averageVoteLabel)
//        addConstraintsWithFormat("H:|[v0(50)]|", views: genreLabel)
//        addConstraintsWithFormat("H:|[v0(50)]|", views: originalLanguageLabel)
//        addConstraintsWithFormat("H:|[v0(50)]|", views: releaseDataLabel)
//
//        addConstraintsWithFormat("V:|[v0(15)][v1(15)][v2(15)][v3(15)]|", views: averageVoteLabel, genreLabel, originalLanguageLabel, releaseDataLabel)
//    }
//    
//    func setupLabelInfoStack() {
//        infoLabelStack.addArrangedSubview(averageVoteInfoLabel)
//        infoLabelStack.addArrangedSubview(genreInfoLabel)
//        infoLabelStack.addArrangedSubview(originalLanguageInfoLabel)
//        infoLabelStack.addArrangedSubview(releaseDataInfoLabel)
//        
//        addConstraintsWithFormat("H:|[v0(50)]|", views: averageVoteInfoLabel)
//        addConstraintsWithFormat("H:|[v0(50)]|", views: genreInfoLabel)
//        addConstraintsWithFormat("H:|[v0(50)]|", views: originalLanguageInfoLabel)
//        addConstraintsWithFormat("H:|[v0(50)]|", views: releaseDataInfoLabel)
//
//        addConstraintsWithFormat("V:|[v0(15)][v1(15)][v2(15)][v3(15)]|", views: averageVoteInfoLabel, genreInfoLabel, originalLanguageInfoLabel, releaseDataInfoLabel)
//    }
//    
//    func setupInfoStack() {
//        infoStack.addArrangedSubview(labelStack)
//        infoStack.addArrangedSubview(infoLabelStack)
//        
//        addConstraintsWithFormat("H:|[v0][v1]|", views: labelStack, infoLabelStack)
//    }
//    
//    func setupMovieStack() {
//        movieInfoStack.addArrangedSubview(posterView)
//        movieInfoStack.addArrangedSubview(titleLabel)
//        movieInfoStack.addArrangedSubview(infoStack)
//        movieInfoStack.addArrangedSubview(overviewLabel)
//        
//        addConstraintsWithFormat("H:|[v0(100)]|", views: posterView)
//        addConstraintsWithFormat("H:|[v0(100)]|", views: titleLabel)
//        addConstraintsWithFormat("H:|[v0(100)]|", views: infoStack)
//        addConstraintsWithFormat("H:|[v0(100)]|", views: overviewLabel)
//
//        addConstraintsWithFormat("V:|[v0(150)][v1(15)][v2(60][v3(60)]|", views: posterView, titleLabel, infoStack, overviewLabel)
//    }
//    
//    func setupView() {
//        getMovies()
//        layer.masksToBounds = false
//        layer.cornerRadius = Constants.menuCornerRadius
//        
//        addSubview(movieInfoStack)
//
//    }
//    
//    func setupConstraints() {
//        
//        let padding = 30
//        
//        addConstraintsWithFormat("H:|-\(padding)-[v0]-\(padding)-|", views: movieInfoStack)
//        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(padding)-|", views: movieInfoStack)
//
//    }
//    
//    func getMovies() {
//        print("Downloading movies")
//    }
//}
//
//class InformationLabel: UILabel {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupProperties()
//        setupAdditionalProperties()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupProperties()
//        setupAdditionalProperties()
//    }
//    
//    // settings similar for all labels
//    func setupProperties() {
//        backgroundColor = UIColor(named: Colors.objectBG.color)
//        layer.masksToBounds = true
//        layer.cornerRadius = Constants.sliderLabelCornerRadius
//    }
//    
//    // additional settings
//    func setupAdditionalProperties() {
//        
//    }
//}
//
//class MovieLabel: InformationLabel {
//
//    // additional settings
//    override func setupAdditionalProperties() {
//        textAlignment = .left
//        textColor = UIColor.white
//        font.withSize(18)
//
//    }
//}
//
//class MovieInfoLabel: InformationLabel {
//    
//    // additional settings
//    override func setupAdditionalProperties() {
//        textAlignment = .left
//        textColor = UIColor.black
//        font.withSize(18)
//
//    }
//}
//
//class TitleLabel: InformationLabel {
//    
//    override func setupAdditionalProperties() {
//        textAlignment = .center
//        textColor = UIColor.green
//        font.withSize(18)
//
//    }
//    
//}
//
//class OverviewLabel: InformationLabel {
//    
//    override func setupAdditionalProperties() {
//        textColor = UIColor.systemPink
//        font.withSize(16)
//
//    }
//    
//}
//
//
//
//
////        addSubview(posterView)
////
////        addSubview(titleLabel)
////
////        addSubview(averageVoteLabel)
////        addSubview(genreLabel)
////        addSubview(originalLanguageLabel)
////        addSubview(releaseDataLabel)
////        addSubview(labelStack) // holds 4 labels (static content)
////
////        addSubview(genreInfoLabel)
////        addSubview(averageVoteInfoLabel)
////        addSubview(originalLanguageInfoLabel)
////        addSubview(releaseDataInfoLabel)
////        addSubview(infoLabelStack) // holds 4 infoLabels (dynaminc content)
////
////        addSubview(infoStack) // holds labelStack and infoLabelStack
////
////        addSubview(overviewLabel)
//
