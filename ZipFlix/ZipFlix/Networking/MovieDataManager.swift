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
