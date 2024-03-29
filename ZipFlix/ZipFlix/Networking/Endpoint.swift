//
//  Endpoint.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum Endpoint {
    case genres
    case people
    case discover1
    case discover2
    
    private var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
        
    func url(page: Int) -> URL {
        switch self {
        case .genres:
            var components = URLComponents(url: baseURL.appendingPathComponent("genre/movie/list"), resolvingAgainstBaseURL: false)
            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(APIKey.key)")]
            return components!.url!
        case .people:
            var components = URLComponents(url: baseURL.appendingPathComponent("person/popular"), resolvingAgainstBaseURL: false)
            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(APIKey.key)"), URLQueryItem(name: "page", value: String(describing: page))]
            return components!.url!
        case .discover1:
            var components = URLComponents(url: baseURL.appendingPathComponent("discover/movie"), resolvingAgainstBaseURL: false)

            let genresSelected = User.getGenreIds()
            let actorsSelected = User.getPersons(for: User.leftUser)
            let voteAverage = User.getAverageRating()

            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(APIKey.key)"), URLQueryItem(name: "with_genres", value: "\(genresSelected)"), URLQueryItem(name: "with_people", value: "\(actorsSelected)"), URLQueryItem(name: "vote_average.gte", value: "\(voteAverage)"), URLQueryItem(name: "page", value: String(describing: page))]
            return components!.url!
        case .discover2:
        var components = URLComponents(url: baseURL.appendingPathComponent("discover/movie"), resolvingAgainstBaseURL: false)

        // These depend on user selection
        let genresSelected = User.getGenreIds()
        let actorsSelected = User.getPersons(for: User.rightUser)
        let voteAverage = User.getAverageRating()

        components?.queryItems = [URLQueryItem(name: "api_key", value: "\(APIKey.key)"), URLQueryItem(name: "with_genres", value: "\(genresSelected)"), URLQueryItem(name: "with_people", value: "\(actorsSelected)"), URLQueryItem(name: "vote_average.gte", value: "\(voteAverage)"), URLQueryItem(name: "page", value: String(describing: page))]
        return components!.url!
        }
        
    }
    
    /*
    Example APi Call:
          https://api.themoviedb.org/3/discover/movie?api_key=ed3e128599234a1dca2c7d4787238741&language=en&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&vote_average.gte=5.0&with_people=1449329&with_genres=28%2C%2018
     
     Broken down:
     - https://api.themoviedb.org/3/discover/movie
     - ?api_key=ed3e128599234a1dca2c7d4787238741
     - &language=en                                 // optional
     - &sort_by=popularity.desc                     // optional 
     - &include_adult=false                         // optional
     - &page=1
     - &vote_average.gte=5.0
     - &with_people=1449329
     - &with_genres=28%2C%2018

     */
}
