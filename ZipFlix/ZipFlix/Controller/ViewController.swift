//
//  ViewController.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    
    var modeSelected: ModeSelected = .lightMode
    
    var zipperState: ZipperState = .open
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }

    var style: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func loadView() {
        self.view = SelectionMenu(frame: UIScreen.main.bounds)
    }
    
    lazy var topButtonBar: TopButtonBar = {
        let topButtonBar = TopButtonBar()
        return topButtonBar
    }()
    
    lazy var statusBarView: UIView = {
        let statusBarView = UIView()
        statusBarView.backgroundColor = UIColor(named: Colors.dmNavBar.color)
        return statusBarView
    }()
    
    lazy var leftSelectionMenu: LeftSelectionMenu = {
        let leftSelectionMenu = LeftSelectionMenu()
        return leftSelectionMenu
    }()
        
    lazy var rightSelectionMenu: RightSelectionMenu = {
        let rightSelectionMenu = RightSelectionMenu()
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
    
    lazy var rightZipperOne: RigthSideZipper = {
        let zipper = RigthSideZipper()
        return zipper
    }()
    
    lazy var rightZipperTwo: RigthSideZipper = {
        let zipper = RigthSideZipper()
        return zipper
    }()
    
    lazy var rightZipperThree: RigthSideZipper = {
        let zipper = RigthSideZipper()
        return zipper
    }()
    
    lazy var rightZipperFour: RigthSideZipper = {
        let zipper = RigthSideZipper()
        return zipper
    }()

    private func setupTopButtonBar() {
        let height = view.safeAreaLayoutGuide.layoutFrame.size.height
        let topBarHeigth = height / 14
    
        view.addSubview(topButtonBar)        
        view.addSubview(statusBarView)
        
        view.addSubview(clearInputButton)
        view.addSubview(modeToggleButton)
        view.addSubview(logoImageView)
        
        let barButtonWidth = view.bounds.width * (2/5)
        let barButtonLogo = view.bounds.width * (1/5)
        
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        statusBarView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        statusBarView.bottomAnchor.constraint(equalTo: topButtonBar.topAnchor).isActive = true
        statusBarView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true

        topButtonBar.translatesAutoresizingMaskIntoConstraints = false
        topButtonBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topButtonBar.heightAnchor.constraint(equalToConstant: topBarHeigth).isActive = true
        topButtonBar.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        
        clearInputButton.translatesAutoresizingMaskIntoConstraints = false
        clearInputButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        clearInputButton.heightAnchor.constraint(equalToConstant: topBarHeigth).isActive = true
        clearInputButton.widthAnchor.constraint(equalToConstant: barButtonWidth).isActive = true
        clearInputButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        modeToggleButton.translatesAutoresizingMaskIntoConstraints = false
        modeToggleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        modeToggleButton.heightAnchor.constraint(equalToConstant: topBarHeigth).isActive = true
        modeToggleButton.widthAnchor.constraint(equalToConstant: barButtonWidth).isActive = true
        modeToggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -12).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 1.5 * topBarHeigth).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: barButtonLogo).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupLeftSelectionMenu() {

        let height = view.bounds.height
        let padding = ((3/14) * height) / 2
                
        let menuWidth = view.bounds.width / 4
        let zipperWidth = menuWidth + 10
        let zipperHeight = menuWidth
        let zipperXOffset = menuWidth / 4
        let zipperSpacing = menuWidth / 5
                
        view.addSubview(leftZipperOne)
        view.addSubview(leftZipperTwo)
        view.addSubview(leftZipperThree)
        view.addSubview(leftZipperFour)
        
        view.addSubview(leftSelectionMenu)

        leftSelectionMenu.translatesAutoresizingMaskIntoConstraints = false
        leftSelectionMenu.topAnchor.constraint(equalTo: topButtonBar.bottomAnchor, constant: padding).isActive = true
        leftSelectionMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftSelectionMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        leftSelectionMenu.widthAnchor.constraint(equalToConstant: menuWidth).isActive = true
                
        leftZipperOne.translatesAutoresizingMaskIntoConstraints = false
        leftZipperOne.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        leftZipperOne.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        leftZipperOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: zipperXOffset).isActive = true
        leftZipperOne.bottomAnchor.constraint(equalTo: leftZipperTwo.topAnchor, constant: -zipperSpacing).isActive = true
        
        leftZipperTwo.translatesAutoresizingMaskIntoConstraints = false
        leftZipperTwo.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        leftZipperTwo.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        leftZipperTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: zipperXOffset).isActive = true
        leftZipperTwo.bottomAnchor.constraint(equalTo: leftSelectionMenu.centerYAnchor, constant: -zipperSpacing / 2).isActive = true

        leftZipperThree.translatesAutoresizingMaskIntoConstraints = false
        leftZipperThree.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        leftZipperThree.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        leftZipperThree.topAnchor.constraint(equalTo: leftSelectionMenu.centerYAnchor, constant: zipperSpacing / 2).isActive = true
        leftZipperThree.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: zipperXOffset).isActive = true

        leftZipperFour.translatesAutoresizingMaskIntoConstraints = false
        leftZipperFour.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        leftZipperFour.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        leftZipperFour.topAnchor.constraint(equalTo: leftZipperThree.bottomAnchor, constant: zipperSpacing).isActive = true
        leftZipperFour.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: zipperXOffset).isActive = true
        
    }
    
    private func setupRightSelectionMenu() {
        let height = view.bounds.height
        let padding = ((3/14) * height) / 2
                
        let menuWidth = view.bounds.width / 4
        let zipperWidth = menuWidth + 10
        let zipperHeight = menuWidth
        let zipperXOffset = -menuWidth / 4
        let zipperSpacing = menuWidth / 5
                
        view.addSubview(rightZipperOne)
        view.addSubview(rightZipperTwo)
        view.addSubview(rightZipperThree)
        view.addSubview(rightZipperFour)
        
        view.addSubview(rightSelectionMenu)

        rightSelectionMenu.translatesAutoresizingMaskIntoConstraints = false
        rightSelectionMenu.topAnchor.constraint(equalTo: topButtonBar.bottomAnchor, constant: padding).isActive = true
        rightSelectionMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        rightSelectionMenu.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding).isActive = true
        rightSelectionMenu.widthAnchor.constraint(equalToConstant: menuWidth).isActive = true
                
        rightZipperOne.translatesAutoresizingMaskIntoConstraints = false
        rightZipperOne.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        rightZipperOne.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        rightZipperOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: zipperXOffset).isActive = true
        rightZipperOne.bottomAnchor.constraint(equalTo: rightZipperTwo.topAnchor, constant: -zipperSpacing).isActive = true
        
        rightZipperTwo.translatesAutoresizingMaskIntoConstraints = false
        rightZipperTwo.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        rightZipperTwo.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        rightZipperTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: zipperXOffset).isActive = true
        rightZipperTwo.bottomAnchor.constraint(equalTo: rightSelectionMenu.centerYAnchor, constant: -zipperSpacing / 2).isActive = true

        rightZipperThree.translatesAutoresizingMaskIntoConstraints = false
        rightZipperThree.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        rightZipperThree.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        rightZipperThree.topAnchor.constraint(equalTo: rightSelectionMenu.centerYAnchor, constant: zipperSpacing / 2).isActive = true
        rightZipperThree.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: zipperXOffset).isActive = true

        rightZipperFour.translatesAutoresizingMaskIntoConstraints = false
        rightZipperFour.widthAnchor.constraint(equalToConstant: zipperWidth).isActive = true
        rightZipperFour.heightAnchor.constraint(equalToConstant: zipperHeight).isActive = true
        rightZipperFour.topAnchor.constraint(equalTo: rightZipperThree.bottomAnchor, constant: zipperSpacing).isActive = true
        rightZipperFour.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: zipperXOffset).isActive = true
    }
    
    private func setupSuggestMovieButton() {
        
        let safeHeigth = view.safeAreaLayoutGuide.layoutFrame.size.height
        let movieButtonSize = ((3/14) * safeHeigth) / 2
        
        view.addSubview(suggestMovieButton)
        
        suggestMovieButton.translatesAutoresizingMaskIntoConstraints = false
        suggestMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        suggestMovieButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        suggestMovieButton.widthAnchor.constraint(equalToConstant: movieButtonSize).isActive = true
        suggestMovieButton.heightAnchor.constraint(equalToConstant: movieButtonSize).isActive = true
    }

}

