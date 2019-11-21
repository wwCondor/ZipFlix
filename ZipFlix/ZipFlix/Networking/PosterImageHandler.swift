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

//class PosterImageHandler {
//
//    static let imageBaseURl = URL(string: "https://image.tmdb.org/t/p/w500")!
//
////    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
////        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
////    }
//}

extension UIImageView {
    func downloaded(from path: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {

        let imageBaseURl: String = "https://image.tmdb.org/t/p/w500/"
        
        let url = URL(string: "\(imageBaseURl)\(path)")!
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(url)
            guard let httpResponse = response as? HTTPURLResponse else {
                print(MovieDBError.requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else {
                    print("MimeType Error")
                    return
                }
                guard let data = data else {
                    print(MovieDBError.invalidData)
                    return
                }
                guard error == nil else {
                    print("Image handling error")
                    return
                }
                guard let image = UIImage(data: data) else {
                    print("No Image")
                    return
                    
                }
                DispatchQueue.main.async() {
                    self.image = image
                }
            } else {
                print("Status Code: \(httpResponse.statusCode)")
            }

        }.resume()
    }
}
