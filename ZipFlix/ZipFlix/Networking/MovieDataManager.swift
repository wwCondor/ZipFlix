//
//  MovieDataManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 15/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class MovieDataManager {
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static let session = URLSession(configuration: .default)
    
    typealias MovieCompletionHandler = ([Movie]?, Error?) -> Void
    
    static func discoverLeftMovies(completion: @escaping MovieCompletionHandler) {
        var allMovies: [Movie] = []
        getLeftMoviePages { (moviePages, error) in
            if let moviePages = moviePages {
                for moviePage in moviePages {
                    guard let movieArray = moviePage.results else {
                        completion(nil, MovieDBError.noResults)
                        return
                    }
                    for movie in movieArray {
                        var movieDuplicates = [Movie]()
                        if !allMovies.contains(movie) {
                            allMovies.append(movie)
                        } else {
                            movieDuplicates.append(movie)
                        }
                    }
                    completion(allMovies, nil)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    static func discoverRightMovies(completion: @escaping MovieCompletionHandler) {
        var allMovies: [Movie] = []
        getRightMoviePages { (moviePages, error) in
            if let moviePages = moviePages {
                for moviePage in moviePages {
                    guard let movieArray = moviePage.results else {
                        completion(nil, MovieDBError.noResults)
                        return
                    }
                    for movie in movieArray {
                        var movieDuplicates = [Movie]()
                        if !allMovies.contains(movie) {
                            allMovies.append(movie)
                        } else {
                            movieDuplicates.append(movie)
                        }
                    }
                    completion(allMovies, nil)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    typealias MoviePagesCompletionHandler = ([Page<Movie>]?, Error?) -> Void
    
    static func getLeftMoviePages(completion: @escaping MoviePagesCompletionHandler) {
        let url = Endpoint.discover1.url(page: 1)
        let allpages = [Page<Movie>]()
        PageHandler.getPages(url: url, pages: allpages, completion: completion)
    }
    
    static func getRightMoviePages(completion: @escaping MoviePagesCompletionHandler) {
        let url = Endpoint.discover2.url(page: 1)
        let allpages = [Page<Movie>]()
        PageHandler.getPages(url: url, pages: allpages, completion: completion)
    }
    
}
