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
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    //initWithCode to init view from storyboard
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
