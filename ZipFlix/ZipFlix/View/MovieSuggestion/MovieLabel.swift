//
//  MovieLabel.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 25/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// MovieLabels used for movieSuggestions screen
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
