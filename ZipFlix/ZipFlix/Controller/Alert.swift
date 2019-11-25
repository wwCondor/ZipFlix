//
//  Alert.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 18/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// Since not all alerts are handled from viewController this also contains a method that allows presentation of alert outside of the main viewController
struct Alert {
    
    static func presentAlert(description: String, viewController: UIViewController) {
        
        let alert = UIAlertController(title: nil, message: description, preferredStyle: .alert)
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(named: Colors.zipper.color)
        alert.view.tintColor = UIColor.white
        
        let confirmation = UIAlertAction(title: "OK", style: .default) {
            (action) in alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirmation)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func presentAlertFromNSObject(description: String) {
        
        let alert = UIAlertController(title: nil, message: description, preferredStyle: .alert)
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(named: Colors.zipper.color)
        alert.view.tintColor = UIColor.white
        
        let confirmation = UIAlertAction(title: "OK", style: .default) {
            (action) in alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(confirmation)
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow } // handles deprecated warning for multiple screens

        if let window = window {
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}
