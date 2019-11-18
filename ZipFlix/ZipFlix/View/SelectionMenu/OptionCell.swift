//
//  OptionCell.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//
//
//import UIKit
//
//class OptionCell: UITableViewCell {
//    
//    lazy var optionLabel: UILabel = {
//        let optionLabel = UILabel()
//        return optionLabel
//    }()
//    
//    func setupCell() {
//        addSubview(optionLabel)
//        
//        let padding = 15
//        
//        addConstraintsWithFormat("H:|[v0]-\(padding)-|", views: optionLabel)
//        addConstraintsWithFormat("V:|[v0]|", views: optionLabel)
//        
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupCell()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupCell()
//    }
//    
//}
