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

class PosterImageHandler {
    
    static let imageBaseURl = URL(string: "https://image.tmdb.org/t/p/w500")!
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func download(from path: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let url = URL(string: path, relativeTo: PosterImageHandler.imageBaseURl)!
        downloaded(from: url, contentMode: mode)
    }
}
