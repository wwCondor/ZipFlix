//
//  LeftSelectionMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 05/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class LeftSelectionMenu: SelectionMenu {
    
    lazy var menuButton: SideMenuButton = {
        let menuButton = SideMenuButton()
        return menuButton
    }()
    
    override func setupView() {
        backgroundColor = UIColor(named:Colors.sideMenuView.color)
//        addBorders(edges: [.top, .right, .bottom], color: .black, inset: 0, thickness: 3.0)
        addSubview(menuButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topRight, .bottomRight], radius: Constants.menuCornerRadius)
    }
}





class RightSelectionMenu: SelectionMenu {
    override func setupView() {
        backgroundColor = UIColor(named:Colors.sideMenuView.color)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .bottomLeft], radius: Constants.menuCornerRadius)
    }
}







class SelectionMenu: UIView {
    //init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    //init from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        
    }
    
    func setupConstraints() {
        
    }
}
