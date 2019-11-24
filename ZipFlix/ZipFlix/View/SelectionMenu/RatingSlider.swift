//
//  RatingMenu.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class RatingSlider: OptionsMenu {
                
    var minimumRating = 5.0
            
    private let optionCellId = "cellId"
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: Colors.objectBG.color)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = Constants.sliderLabelCornerRadius
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font.withSize(18)
        label.text = "Minimum Rating"
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        slider.minimumTrackTintColor = UIColor(named: Colors.objectBG.color)
        slider.maximumTrackTintColor = UIColor.white.withAlphaComponent(Constants.dimAlpha)
        slider.thumbTintColor = UIColor.white
        slider.maximumValue = 8.5
        slider.minimumValue = 0
        slider.setValue(5.0, animated: false)
        slider.addTarget(self, action: #selector(changeRating(_:)), for: .valueChanged)
        slider.backgroundColor = UIColor.clear
        return slider
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: Colors.objectBG.color)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = Constants.sliderLabelCornerRadius
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "\(minimumRating)"
        return label
    }()
    
    override func setupView() {
        addSubview(slider)
        addSubview(textLabel)
        addSubview(ratingLabel)
        addObserver()
        
        let sliderImage = UIImage(named: Icons.zipperThumb.image)?.withRenderingMode(.alwaysOriginal) // default thumb is 30x30
        slider.setThumbImage(sliderImage, for: .normal)
        slider.setThumbImage(sliderImage, for: .highlighted)
    }
    
    override func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(removeSelection), name: clearInputNotification, object: nil)
    }
    
    override func removeSelection(sender: Notification) {
        slider.setValue(5.0, animated: false)
        ratingLabel.text = "5.0"
    }

    override func setupConstraints() {
        let padding = 30
        let spacing = 15
        let labelHeigth = 50

        addConstraintsWithFormat("H:|-\(padding)-[v0]-\(padding)-|", views: slider)
        addConstraintsWithFormat("H:|-\(padding)-[v0]-\(padding)-|", views: textLabel)
        addConstraintsWithFormat("H:|-\(padding)-[v0]-\(padding)-|", views: ratingLabel)

        addConstraintsWithFormat("V:|-\(padding)-[v0]-\(spacing)-[v1(\(labelHeigth))]-\(spacing)-[v2(\(labelHeigth))]-\(padding)-|", views: slider, textLabel, ratingLabel)
    }
    
    @objc func changeRating(_ sender: UISlider) {
        let voteAverage = Float(sender.value)
        ratingLabel.text = String(format: "%.1f", voteAverage)
        minimumRating = Double(round(voteAverage * 10))/10 // make sure we have 1 decimal
    }
    
}
