//
//  ViewController.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 04/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//
// Icons made by Pixel perfect from https://www.flaticon.com/

import UIKit

class ViewController: UIViewController {
    
    var modeSelected: ModeSelected = .lightMode
        
//    var clearIconImage = UIImage(named: Icons.reset.image)!.withRenderingMode(.alwaysTemplate)
//    var modeIconImage = UIImage(named: Icons.lightModeIcon.image)!.withRenderingMode(.alwaysOriginal)
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return self.style
//    }
//
//    var style: UIStatusBarStyle = .lightContent

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        setupNavigationBar()
        setupView()
        self.navigationController?.navigationBar.barStyle = .black

        
        if modeSelected == .lightMode {
            view.backgroundColor = UIColor(named: Colors.lmBackground.color)
        } else if modeSelected == .darkMode {
            view.backgroundColor = UIColor(named: Colors.dmBackground.color)
        }
    }
    
    lazy var menuBar: UIView = {
        let menuBar = UIView()
        menuBar.backgroundColor = UIColor.systemRed
        return menuBar
    }()

    private func setupMenuBar() {
//        menuBar.addSubview(clearInputButton)
//        menuBar.addSubview(titleImageView)
//        menuBar.addSubview(modeSelectionButton)
//        view.addSubview(menuBar)
        
//        menuBar.addConstraintsWithFormat("H:|[v0][v1][v2]|", views: clearInputButton, titleImageView, modeSelectionButton)
//        menuBar.addConstraintsWithFormat("V:[v0(60)]", views: clearInputButton)
//        menuBar.addConstraintsWithFormat("V:[v0(60)]", views: titleImageView)
//        menuBar.addConstraintsWithFormat("V:[v0(60)]", views: modeSelectionButton)
//        let menuBarButtonWidth = view.bounds.width / 3
                
//        clearInputButton.translatesAutoresizingMaskIntoConstraints = false
//        titleImageView.translatesAutoresizingMaskIntoConstraints = false
//        modeSelectionButton.translatesAutoresizingMaskIntoConstraints = false
//
//        clearInputButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        titleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        modeSelectionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//
//        clearInputButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        titleImageView.leadingAnchor.constraint(equalTo: clearInputButton.trailingAnchor).isActive = true
//        modeSelectionButton.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor).isActive = true
//
//        clearInputButton.widthAnchor.constraint(equalToConstant: menuBarButtonWidth).isActive = true
//        titleImageView.widthAnchor.constraint(equalToConstant: menuBarButtonWidth).isActive = true
//        modeSelectionButton.widthAnchor.constraint(equalToConstant: menuBarButtonWidth).isActive = true

//        clearInputButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        titleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        modeSelectionButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupNavigationBar() {
        let titleImageView = LogoImageView(image: UIImage(named: Icons.zipperIcon.image)!)
//        titleImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width / 3, height: Constants.iconSize)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(runAnimation(tapGestureRecognizer:)))
        titleImageView.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.titleView = titleImageView
        
        let clearInputButton = ClearInputButton(type: .system)
//        clearInputButton.frame = CGRect(x: 0, y: 0, width: view.frame.width / 3, height: Constants.iconSize)
        clearInputButton.addTarget(self, action: #selector(clearInput(sender:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: clearInputButton)
        
        let modeSelectionButton = ModeToggleButton(type: .system)
//        modeSelectionButton.frame = CGRect(x: 0, y: 0, width: view.frame.width / 3, height: Constants.iconSize)
        modeSelectionButton.addTarget(self, action: #selector(switchMode(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: modeSelectionButton)
        
        // Navigation bar shadow
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 15
    }
    
    private func setupView() {
        
        
    }
    
    @objc func clearInput(sender: UIBarButtonItem) {
        print("Cleared Input")
    }
    
//    let clearButton = ClearInputButton()

    @objc func switchMode(sender: UIBarButtonItem) {
        let lightModeNotification = Notification.Name(rawValue: Constants.lightModeNotificationKey)
        let darkModeNotification = Notification.Name(rawValue: Constants.darkModeNotificationKey)

        if modeSelected == .darkMode {
            DispatchQueue.main.async {
                self.modeSelected = .lightMode
                
                self.navigationController?.navigationBar.barStyle = .black
                self.setNeedsStatusBarAppearanceUpdate()
                
                NotificationCenter.default.removeObserver(darkModeNotification)
                NotificationCenter.default.post(name: lightModeNotification, object: nil)

                self.view.backgroundColor = UIColor(named: Colors.lmBackground.color)
            }

        } else if modeSelected == .lightMode {
            DispatchQueue.main.async {
                self.modeSelected = .darkMode
                
                self.navigationController?.navigationBar.barStyle = .default
                self.setNeedsStatusBarAppearanceUpdate()
                
                NotificationCenter.default.removeObserver(lightModeNotification)
                NotificationCenter.default.post(name: darkModeNotification, object: nil)

                self.view.backgroundColor = UIColor(named: Colors.dmBackground.color)
            }
        }
    }

    @objc func runAnimation(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Animation started")
    }
    
}

