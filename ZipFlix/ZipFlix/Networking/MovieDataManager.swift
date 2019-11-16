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
    
    static func discoverMovies(completion: @escaping MovieCompletionHandler) {
        var allMovies = [Movie]()
                getAllMovies { (moviePages, error) in
                    // first we check wether have pages
                    if let moviePages = moviePages {
                        // If we have pages we check for each page if it contains results
                        for moviePage in moviePages {
                            guard let movieArray = moviePage.results else {
                                print("Unable to obtain people array from pages")
                                completion(nil, error)
                                return
                            }
                            // If it does, each character inside results will be added to an array
                            for movie in movieArray {
                                var movieDuplicates = [Movie]()
                                if !allMovies.contains(movie) {
                                    allMovies.append(movie)
                                    print("***")
                                    print("\(String(describing: movie.title)) added to array; total: \(allMovies.count)")
                                } else {
                                    movieDuplicates.append(movie)
                                }
                            }
                            completion(allMovies, nil)
                        }
                    } else if let error = error {
                        print(error)
                        completion(nil, error)
                    }
                }
    }
    
    
    typealias MoviePagesCompletionHandler = ([Page<Movie>]?, Error?) -> Void
    
    static func getAllMovies(completion: @escaping MoviePagesCompletionHandler) {
        let url = Endpoint.discover.url(page: 1)
        let allpages = [Page<Movie>]()
        
        MovieDataManager.getAllResourcePages(url: url, pages: allpages, completionHandler: completion)
    }
    
    static func getAllResourcePages<T>(url: URL, pages: [Page<T>], completionHandler completion: @escaping ([Page<T>]?, Error?) -> Void) {
            var allData = pages
            MovieDataManager.getResourcePage(url: url) { (page: Page<T>?, error: Error?) in
                if let page = page {
                    allData.append(page)
                    
                    let currentPage = page.page
                    // Now we appened one page, if there is a "next" page we will repeat this process
                    let next = Endpoint.people.url(page: currentPage! + 1)
                    
                    MovieDataManager.getAllResourcePages(url: next, pages: allData, completionHandler: completion)
//                    if let next = page.next {
//
//                        // If there is no "next" it means we have obtained all the data pages
//                    } else {
//                        completion(allData, nil)
//                    }
                } else if let error = error {
                    print(error)
                    completion(nil, error)
                }
                
            }
        }
        
        // Here we retrieve one page of data from the API
        static func getResourcePage<T>(url: URL, completionHandler completion: @escaping (Page<T>?, Error?) -> Void) {
         
            let request = URLRequest(url: url)
            
            let task = MovieDataManager.session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            completion(nil, MovieDBError.requestFailed)
                            return
                        }
                        
                        if 200...299 ~= httpResponse.statusCode {
    //                        print("Status Code: \(httpResponse.statusCode)")
                            
                            do {
                                let results = try MovieDataManager.decoder.decode(Page<T>.self, from: data)
                                //                            print(results)
                                completion(results, nil)
                            } catch let error {
    //                            print(error)
                                completion(nil, error)
                            }
                            
                        } else {
                            completion(nil, MovieDBError.invalidData)
                        }
                        
                    } else if let error = error {
                        completion(nil, error)
                    }
                }
            }
            task.resume()
        }
    
}







/*
 
 Example response for discover:

 https://api.themoviedb.org/3/discover/movie?api_key=ed3e128599234a1dca2c7d4787238741&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=5

 https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg // image URL for movie for poster_path

 {
   "page": 5,
   "total_results": 10000,
   "total_pages": 500,
   "results": [
     {
       "popularity": 39.823,
       "vote_count": 10469,
       "video": false,
       "poster_path": "/eFnGmj63QPUpK7QUWSOUhypIQOT.jpg",
       "id": 109445,
       "adult": false,
       "backdrop_path": "/cN9Nbwh66TRcj2gBE8cSEZulsx3.jpg",
       "original_language": "en",
       "original_title": "Frozen",
       "genre_ids": [
         12,
         16,
         10751
       ],
       "title": "Frozen",
       "vote_average": 7.3,
       "overview": "Young princess Anna of Arendelle dreams about finding true love at her sister Elsa’s coronation. Fate takes her on a dangerous journey in an attempt to end the eternal winter that has fallen over the kingdom. She's accompanied by ice delivery man Kristoff, his reindeer Sven, and snowman Olaf. On an adventure where she will find out what friendship, courage, family, and true love really means.",
       "release_date": "2013-11-27"
     }
   ]
 }
 
 */
