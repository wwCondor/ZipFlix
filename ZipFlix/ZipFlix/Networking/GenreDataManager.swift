//
//  Client.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class GenreDataManager {

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    static let session = URLSession(configuration: .default)
    
    typealias GenresCompletionHandler = (Genres?, Error?)-> Void
    typealias GenreItemsCompletionHandler = ([Genre]?, Error?) -> Void
    
    static func fetchGenres(completion: @escaping GenreItemsCompletionHandler) {
        var allGenres = [Genre]()
        getGenres { (genreObject, error) in
            guard let genres = genreObject?.genres else {
                completion(nil, MovieDBError.noResults)
                return
            }
            for genre in genres {
                allGenres.append(genre)
            }
            completion(allGenres, nil)
        }
    }

    static func getGenres(completion: @escaping GenresCompletionHandler) {
        
        let genreUrl = Endpoint.genres.url(page: 1)

        let request = URLRequest(url: genreUrl)

        let task = GenreDataManager.session.dataTask(with: request) { data, response, error in
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, MovieDBError.requestFailed)
                        return
                    }
                    if 200...299 ~= httpResponse.statusCode {
                        do {
                            let genres = try GenreDataManager.decoder.decode(Genres.self, from: data)
                            completion(genres, nil)
                        } catch {
                            completion(nil, MovieDBError.jsonDecodingFailure)
                        }
                    } else {
                        completion(nil, MovieDBError.responseUnsuccessful)
                    }
                } else {
                    completion(nil, MovieDBError.noData)
                }
        }
        task.resume()
    }
}
