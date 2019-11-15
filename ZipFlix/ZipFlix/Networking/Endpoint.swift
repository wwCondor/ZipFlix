//
//  Endpoint.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//  https://api.themoviedb.org/3/person/popular?api_key=ed3e128599234a1dca2c7d4787238741&page=1

import Foundation

enum Endpoint {
    case genres
    case people
    case discover
    
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
        case .discover:
            var components = URLComponents(url: baseURL.appendingPathComponent("discover/movie"), resolvingAgainstBaseURL: false)

            let genresSelected = "some array of genres"
            let actorsSelected = "some array of actors"

            components?.queryItems = [URLQueryItem(name: "api_key", value: "\(APIKey.key)"), URLQueryItem(name: "with_genres", value: "\(genresSelected)"), URLQueryItem(name: "with_people", value: "\(actorsSelected)"), URLQueryItem(name: "page", value: String(describing: page))]
            return components!.url!
        }
    }
    
//    static func getGenres(for someArray: [Genre]) -> String {
//        var returnedString = ""
//
//        // In here we need to create a string that depends on the selected genres
//        // Inbetween the selected genres we need to add some spacing
//
////        for genre in someArray {
////            returnedString += String(describing: genre.id) + "|"
////        }
//        return returnedString
//    }
}
