//
//  MovieDBClient.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

//class MovieClient: APIClient {
//    var session: URLSession
//    
//    init(configuration: URLSessionConfiguration) {
//        self.session = URLSession(configuration: configuration)
//    }
//    
//    static let baseUrl: URL = {
//        return URL(string:"https://api.themoviedb.org/3/")!
//    }()
//    
//    func getGenres(with url: URL, completion: @escaping (Result<[Genre], MovieDBError>) -> Void) {
//        
//        let url = URL(string: "genre/movie/list?api_key=\(APIKey.key)", relativeTo: MovieClient.baseUrl)!
//        
//        fetch(with: url, parse: { json -> [Genre] in
//            guard let genres = json["genres"] as? [[String: Any]] else {
//                return []
//            }
//            
//            return genres.compactMap { Genre(json: $0) }
//            
//        }, completion: completion)
//
//        
//        
//    }
//    
//}
