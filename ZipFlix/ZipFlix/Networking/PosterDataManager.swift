//
//  PosterImageHandler.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 20/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation
import UIKit

// ExampleUrl: https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg

extension UIImageView {
    func downloaded(from path: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {

        let imageBaseURl: String = "https://image.tmdb.org/t/p/w500/"
        
        let url = URL(string: "\(imageBaseURl)\(path)")!
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async() {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    guard let data = data else {
                        return
                    }
                    guard error == nil else {
                        return
                    }
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    self.image = image
                } else {
                    print("Status Code: \(httpResponse.statusCode)")
                }
            }
        }.resume()
    }
}
