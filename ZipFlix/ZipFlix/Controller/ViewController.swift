//
//  ViewController.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let clearInputNotification = Notification.Name(rawValue: Constants.clearInputNotificationKey)
    
    let movieSuggestionsManager = MovieSuggestionManager()
    let selectionManager = GenreMenuManager()
        
    var modeSelected: ModeSelected = .lightMode
    var zipperState: ZipperState = .open
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }

    var style: UIStatusBarStyle = .lightContent // default setting for statusBar
        
    func addObserver() {
        // Listens for clearInputNotification posted by movie suggestion when dismissed, and opens zipper
        NotificationCenter.default.addObserver(self, selector: #selector(openZipper(sender:)), name: clearInputNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        addObserver()
        setupTopButtonBar()
        setupLeftSelectionMenu()
        setupRightSelectionMenu()
        setupSuggestMovieButton()

        if modeSelected == .lightMode {
            view.backgroundColor = UIColor(named: Colors.lmBackground.color)
        } else if modeSelected == .darkMode {
            view.backgroundColor = UIColor(named: Colors.dmBackground.color)
        }
    }
    
    lazy var topButtonBar: TopButtonBar = {
        let topButtonBar = TopButtonBar()
        return topButtonBar
    }()
    
    lazy var statusBarView: UIView = {
        let statusBarView = UIView()
        statusBarView.backgroundColor = UIColor(named: Colors.objectBG.color)
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        return statusBarView
    }()
    
    lazy var leftSelectionMenu: LeftSelectionMenuLauncher = {
        let leftSelectionMenu = LeftSelectionMenuLauncher()
        return leftSelectionMenu
    }()
        
    lazy var rightSelectionMenu: RightSelectionMenuLauncher = {
        let rightSelectionMenu = RightSelectionMenuLauncher()
        return rightSelectionMenu
    }()
    
    lazy var suggestMovieButton: SuggestMovieButton = {
        let suggestMovieButton = SuggestMovieButton()
        suggestMovieButton.addTarget(self, action: #selector(suggestMovie(sender:)), for: .touchUpInside)
        return suggestMovieButton
    }()
    
    lazy var logoImageView: LogoImageView = {
        let zipperIcon = UIImage(named: Icons.zipperIcon.image)!
        let logoImageView = LogoImageView(image: zipperIcon)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runAnimation(tapGestureRecognizer:)))
        logoImageView.addGestureRecognizer(tapGestureRecognizer)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    lazy var clearInputButton: ClearInputButton = {
        let clearInputButton = ClearInputButton(type: .system)
        clearInputButton.addTarget(self, action: #selector(clearInput(sender:)), for: .touchUpInside)
        return clearInputButton
    }()
    
    lazy var modeToggleButton: ModeToggleButton = {
        let modeToggleButton = ModeToggleButton(type: .system)
        modeToggleButton.addTarget(self, action: #selector(switchMode(sender:)), for: .touchUpInside)
        return modeToggleButton
    }()
    
    lazy var leftZipperOne: LeftSideZipper = {
        let zipper = LeftSideZipper()
        return zipper
    }()
    
    lazy var leftZipperTwo: LeftSideZipper = {
        let zipper = LeftSideZipper()
        return zipper
    }()
    
    lazy var leftZipperThree: LeftSideZipper = {
        let zipper = LeftSideZipper()
        return zipper
    }()
    
    lazy var leftZipperFour: LeftSideZipper = {
        let zipper = LeftSideZipper()
        return zipper
    }()
    
    lazy var leftZipperFive: LeftSideZipper = {
        let zipper = LeftSideZipper()
        return zipper
    }()
    
    lazy var leftZipperSix: LeftSideZipper = {
        let zipper = LeftSideZipper()
        return zipper
    }()
    
    lazy var rightZipperOne: RightSideZipper = {
        let zipper = RightSideZipper()
        return zipper
    }()
    
    lazy var rightZipperTwo: RightSideZipper = {
        let zipper = RightSideZipper()
        return zipper
    }()
    
    lazy var rightZipperThree: RightSideZipper = {
        let zipper = RightSideZipper()
        return zipper
    }()
    
    lazy var rightZipperFour: RightSideZipper = {
        let zipper = RightSideZipper()
        return zipper
    }()
    
    lazy var rightZipperFive: RightSideZipper = {
        let zipper = RightSideZipper()
        return zipper
    }()
    
    lazy var rightZipperSix: RightSideZipper = {
        let zipper = RightSideZipper()
        return zipper
    }()

    private func setupTopButtonBar() {
        let height = view.bounds.height
        let topBarHeigth = height / 14
    
        view.addSubview(topButtonBar)        
        view.addSubview(statusBarView)
        
        view.addSubview(clearInputButton)
        view.addSubview(modeToggleButton)
        view.addSubview(logoImageView)
        
        let barButtonWidth = view.bounds.width * (2/5)
        let barButtonLogo = view.bounds.width * (1/5)

        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.bottomAnchor.constraint(equalTo: topButtonBar.topAnchor),
            statusBarView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            topButtonBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topButtonBar.heightAnchor.constraint(equalToConstant: topBarHeigth),
            topButtonBar.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            clearInputButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            clearInputButton.heightAnchor.constraint(equalToConstant: topBarHeigth),
            clearInputButton.widthAnchor.constraint(equalToConstant: barButtonWidth),
            clearInputButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            modeToggleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            modeToggleButton.heightAnchor.constraint(equalToConstant: topBarHeigth),
            modeToggleButton.widthAnchor.constraint(equalToConstant: barButtonWidth),
            modeToggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -12),
            logoImageView.heightAnchor.constraint(equalToConstant: 1.5 * topBarHeigth),
            logoImageView.widthAnchor.constraint(equalToConstant: barButtonLogo),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLeftSelectionMenu() {

        let height = view.bounds.height
        let padding = ((3/14) * height) / 2
                
        let menuWidth = view.bounds.width / 3
        let zipperSize = menuWidth / 2
        let zipperWidth = zipperSize + 10
        let zipperHeight = zipperSize
        let zipperXOffset = zipperSize * (1 / 4)
        let zipperSpacing = zipperSize / 6
                
        view.addSubview(leftZipperOne)
        view.addSubview(leftZipperTwo)
        view.addSubview(leftZipperThree)
        view.addSubview(leftZipperFour)
        view.addSubview(leftZipperFive)
        view.addSubview(leftZipperSix)
        
        view.addSubview(leftSelectionMenu)

        NSLayoutConstraint.activate([
            leftSelectionMenu.topAnchor.constraint(equalTo: topButtonBar.bottomAnchor, constant: padding),
            leftSelectionMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftSelectionMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            leftSelectionMenu.widthAnchor.constraint(equalToConstant: menuWidth),
            
            leftZipperOne.widthAnchor.constraint(equalToConstant: zipperWidth),
            leftZipperOne.heightAnchor.constraint(equalToConstant: zipperHeight),
            leftZipperOne.bottomAnchor.constraint(equalTo: leftZipperTwo.topAnchor, constant: -zipperSpacing),
            leftZipperOne.centerXAnchor.constraint(equalTo: leftSelectionMenu.trailingAnchor, constant: -zipperXOffset),
            
            leftZipperTwo.widthAnchor.constraint(equalToConstant: zipperWidth),
            leftZipperTwo.heightAnchor.constraint(equalToConstant: zipperHeight),
            leftZipperTwo.bottomAnchor.constraint(equalTo: leftZipperThree.topAnchor, constant: -zipperSpacing),
            leftZipperTwo.centerXAnchor.constraint(equalTo: leftSelectionMenu.trailingAnchor, constant: -zipperXOffset),
            
            leftZipperThree.widthAnchor.constraint(equalToConstant: zipperWidth),
            leftZipperThree.heightAnchor.constraint(equalToConstant: zipperHeight),
            leftZipperThree.bottomAnchor.constraint(equalTo: leftSelectionMenu.centerYAnchor, constant: -zipperSpacing / 2),
            leftZipperThree.centerXAnchor.constraint(equalTo: leftSelectionMenu.trailingAnchor, constant: -zipperXOffset),
            
            leftZipperFour.widthAnchor.constraint(equalToConstant: zipperWidth),
            leftZipperFour.heightAnchor.constraint(equalToConstant: zipperHeight),
            leftZipperFour.topAnchor.constraint(equalTo: leftSelectionMenu.centerYAnchor, constant: zipperSpacing / 2),
            leftZipperFour.centerXAnchor.constraint(equalTo: leftSelectionMenu.trailingAnchor, constant: -zipperXOffset),
            
            leftZipperFive.widthAnchor.constraint(equalToConstant: zipperWidth),
            leftZipperFive.heightAnchor.constraint(equalToConstant: zipperHeight),
            leftZipperFive.topAnchor.constraint(equalTo: leftZipperFour.bottomAnchor, constant: zipperSpacing),
            leftZipperFive.centerXAnchor.constraint(equalTo: leftSelectionMenu.trailingAnchor, constant: -zipperXOffset),
            
            leftZipperSix.widthAnchor.constraint(equalToConstant: zipperWidth),
            leftZipperSix.heightAnchor.constraint(equalToConstant: zipperHeight),
            leftZipperSix.topAnchor.constraint(equalTo: leftZipperFive.bottomAnchor, constant: zipperSpacing),
            leftZipperSix.centerXAnchor.constraint(equalTo: leftSelectionMenu.trailingAnchor, constant: -zipperXOffset)
        ])
    }
    
    private func setupRightSelectionMenu() {
        let height = view.bounds.height
        let padding = ((3/14) * height) / 2
                
        let menuWidth = view.bounds.width / 3
        let zipperSize = menuWidth / 2
        let zipperWidth = zipperSize + 10
        let zipperHeight = zipperSize
        let zipperXOffset = zipperSize * (1 / 4)
        let zipperSpacing = zipperSize / 6
                
        view.addSubview(rightZipperOne)
        view.addSubview(rightZipperTwo)
        view.addSubview(rightZipperThree)
        view.addSubview(rightZipperFour)
        view.addSubview(rightZipperFive)
        view.addSubview(rightZipperSix)
        
        view.addSubview(rightSelectionMenu)

        NSLayoutConstraint.activate([
            rightSelectionMenu.topAnchor.constraint(equalTo: topButtonBar.bottomAnchor, constant: padding),
            rightSelectionMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightSelectionMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            rightSelectionMenu.widthAnchor.constraint(equalToConstant: menuWidth),
            
            rightZipperOne.widthAnchor.constraint(equalToConstant: zipperWidth),
            rightZipperOne.heightAnchor.constraint(equalToConstant: zipperHeight),
            rightZipperOne.bottomAnchor.constraint(equalTo: rightZipperTwo.topAnchor, constant: -zipperSpacing),
            rightZipperOne.centerXAnchor.constraint(equalTo: rightSelectionMenu.leadingAnchor, constant: zipperXOffset),
            
            rightZipperTwo.widthAnchor.constraint(equalToConstant: zipperWidth),
            rightZipperTwo.heightAnchor.constraint(equalToConstant: zipperHeight),
            rightZipperTwo.bottomAnchor.constraint(equalTo: rightZipperThree.topAnchor, constant: -zipperSpacing),
            rightZipperTwo.centerXAnchor.constraint(equalTo: rightSelectionMenu.leadingAnchor, constant: zipperXOffset),
            
            rightZipperThree.widthAnchor.constraint(equalToConstant: zipperWidth),
            rightZipperThree.heightAnchor.constraint(equalToConstant: zipperHeight),
            rightZipperThree.bottomAnchor.constraint(equalTo: rightSelectionMenu.centerYAnchor, constant: -zipperSpacing / 2),
            rightZipperThree.centerXAnchor.constraint(equalTo: rightSelectionMenu.leadingAnchor, constant: zipperXOffset),
            
            rightZipperFour.widthAnchor.constraint(equalToConstant: zipperWidth),
            rightZipperFour.heightAnchor.constraint(equalToConstant: zipperHeight),
            rightZipperFour.topAnchor.constraint(equalTo: rightSelectionMenu.centerYAnchor, constant: zipperSpacing / 2),
            rightZipperFour.centerXAnchor.constraint(equalTo: rightSelectionMenu.leadingAnchor, constant: zipperXOffset),
            
            rightZipperFive.widthAnchor.constraint(equalToConstant: zipperWidth),
            rightZipperFive.heightAnchor.constraint(equalToConstant: zipperHeight),
            rightZipperFive.topAnchor.constraint(equalTo: rightZipperFour.bottomAnchor, constant: zipperSpacing),
            rightZipperFive.centerXAnchor.constraint(equalTo: rightSelectionMenu.leadingAnchor, constant: zipperXOffset),
            
            rightZipperSix.widthAnchor.constraint(equalToConstant: zipperWidth),
            rightZipperSix.heightAnchor.constraint(equalToConstant: zipperHeight),
            rightZipperSix.topAnchor.constraint(equalTo: rightZipperFive.bottomAnchor, constant: zipperSpacing),
            rightZipperSix.centerXAnchor.constraint(equalTo: rightSelectionMenu.leadingAnchor, constant: zipperXOffset)
        ])
    }
    
    private func setupSuggestMovieButton() {
        let height = view.bounds.height
        let movieButtonSize = ((3/14) * height) / 2
        
        view.addSubview(suggestMovieButton)
                
        NSLayoutConstraint.activate([
        suggestMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        suggestMovieButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        suggestMovieButton.widthAnchor.constraint(equalToConstant: movieButtonSize),
        suggestMovieButton.heightAnchor.constraint(equalToConstant: movieButtonSize)
        ])
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
