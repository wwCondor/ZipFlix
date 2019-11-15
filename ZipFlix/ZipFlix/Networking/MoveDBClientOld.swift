////
////  MovieDBClient.swift
////  ZipFlix
////
////  Created by Wouter Willebrands on 13/11/2019.
////  Copyright © 2019 Studio Willebrands. All rights reserved.
////
//
///*
// {
//"page": 1,
//"total_results": 4,
//"total_pages": 1,
//"results": [
//{
//  "popularity": 13.141,
//  "vote_count": 3132,
//  "video": false,
//  "poster_path": "/lYfRc57Kx9VgLZ48iulu0HKnM15.jpg",
//  "id": 856,
//  "adult": false,
//  "backdrop_path": "/9podqGmd36AJHO13HQIQHQZRTJC.jpg",
//  "original_language": "en",
//  "original_title": "Who Framed Roger Rabbit",
//  "genre_ids": [
//    16,
//    35,
//    80,
//    14,
//    10751
//  ],
//  "title": "Who Framed Roger Rabbit",
//  "vote_average": 7.4,
//  "overview": "'Toon star Roger is worried that his wife Jessica is playing pattycake with someone else, so the studio hires detective Eddie Valiant to snoop on her. But the stakes are quickly raised when Marvin Acme is found dead and Roger is the prime suspect.",
//  "release_date": "1988-06-21"
//}
//]
// }
// */
//
//import Foundation
//
//
//
//
//class MovieDBClient {
//
//    static let baseUrl: URL = {
//        return URL(string:"https://api.themoviedb.org/3/")!
//    }()
//
//    static let decoder: JSONDecoder = {
//        let decoder = JSONDecoder()
//        return decoder
//    }()
//
//    static var pageNumber: Int = 1
//
//    static let session = URLSession(configuration: .default)
//
//    static let moviesUrl: URL = {
//        return URL(string: "\(baseUrl)discover/movie?api_key=\(APIKey.key)&language=en&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(pageNumber)&with_genres=80%2C%2035%2C%2016%2C%2014")!
//    }()
//
////    func createMovieUrl(int: Int) -> URL{
////        let baseURL: URL = URL(string:"https://api.themoviedb.org/3/")!
////        let
////        let key = APIKey.key
////
////        let movieURL: URL =
////
////
////        return movieURL
////    }
//
//
////    guard let url = URL(string: "genre/movie/list?api_key=\(apiKey)", relativeTo: baseUrl) else {
////        completion(nil, MovieDBError.invalidUrl)
////        return
////    }
//
////    "page": 1,
////    "total_results": 4,
////    "total_pages": 1,
//
//    typealias MovieCompletionHandler = ([Movie]?, Error?)-> Void
//    typealias MoviePagesCompletionHandler = ([Page<Movie>]?, Error?)-> Void
//
//    static func fetchMovies(completion: @escaping MovieCompletionHandler) {
//            var allMovies = [Movie]()
//            getMovies { (moviePages, error) in
//                // first we check wether have pages
//                if let moviePages = moviePages {
//                    // If we have pages we check for each page if it contains results
//                    for moviePage in moviePages {
//                        let movieArray = moviePage.results
//    //                        print("Unable to obtain character array from pages")
////                            completion(nil, error)
////                            return
//
//                        // If it does, each character inside results will be added to an array
//                        for movie in movieArray {
//                            var movieDuplicates = [Movie]()
//                            if !allMovies.contains(movie) {
//                                allMovies.append(movie)
//                                print("***")
//                                print("\(String(describing: movie.title)) added to array; total: \(allMovies.count)")
//                            } else {
//                                movieDuplicates.append(movie)
//                            }
//                        }
//                        completion(allMovies, error)
//                    }
//                } else if let error = error {
//                    print(error)
//                    completion(nil, error)
//                }
//            }
//        }
//
//    static func getMovies(completion: @escaping MoviePagesCompletionHandler) {
//        guard let url = URL(string: "someString", relativeTo: baseUrl) else {
//            completion(nil, MovieDBError.invalidUrl)
//            return
//        }
//
//        let allData = [Page<Movie>]()
//        MovieDBClient.getAllMoviePages(url: url, pages: allData, completionHandler: completion)
//    }
//
//    static func getAllMoviePages<T>(url: URL, pages: [Page<T>], completionHandler completion: @escaping ([Page<T>]?, Error?) -> Void) {
//        var allData = pages
//        MovieDBClient.getMoviePage(url: url) { (page: Page<T>?, error: Error?) in
////            var pageNumber: Int = 1
//            if let page = page {
//                allData.append(page)
//                if page.page != page.totalPages  {
//                    let nextPage = URL(string: "someString with page + 1", relativeTo: baseUrl)!
//                    print(pageNumber)
//                    MovieDBClient.getAllMoviePages(url: nextPage, pages: allData, completionHandler: completion)
//                } else {
//                    completion(allData, nil)
//                }
//            } else if let error = error {
//                print(error)
//                completion(nil, error)
//            }
//        }
//    }
//
//    static func getMoviePage<T>(url: URL, completion: @escaping (Page<T>?, Error?) -> Void) {
//
////        guard let url = URL(string: "discover/movie?api_key=\(apiKey)&language=en&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(pageNumber)&with_genres=80%2C%2035%2C%2016%2C%2014", relativeTo: baseUrl) else {
////            completion(nil, MovieDBError.invalidUrl)
////            return
////        }
//
//        let request = URLRequest(url: url)
//
//        let task = Client.session.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//
//                    guard let httpResponse = response as? HTTPURLResponse else {
//                        completion(nil, MovieDBError.requestFailed)
//                        return
//                    }
//
//                    if 200...299 ~= httpResponse.statusCode {
//                        print("Status Code: \(httpResponse.statusCode)")
//
//                        do {
//                            let results = try Client.decoder.decode(Page<T>.self, from: data)
//                            completion(results, nil)
//
//                        } catch {
//                            completion(nil, MovieDBError.jsonDecodingFailure)
//                        }
//
//                    } else {
//                        completion(nil, MovieDBError.responseUnsuccessful)
//                    }
//
//                } else if let error = error {
//                    completion(nil, error)
//                }
//            }
//        }
//        task.resume()
//    }
//
//}
