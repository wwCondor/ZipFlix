//
//  Client.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class Client {
    
    fileprivate let apiKey: String = "ed3e128599234a1dca2c7d4787238741"
    
    lazy var baseUrl: URL = {
        return URL(string: "https://api.themoviedb.org/3/movie/550?api_key=\(self.apiKey)")!
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
}
