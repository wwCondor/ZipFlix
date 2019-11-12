//
//  Movie.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    
    let title: String? //yes
    let id: Int? //yes
    
    let popularity: Int? //maybe?
    
    let voteCount: Int? // yes
    let voteAverage: Int? // yes
    let releaseDate: String?
    
    let adult: Bool? // maybe
    let genreIds: [Int]? //probably
    let posterPath: String? // yes dimension: 500x750
    let overview: String
    
}


//{
//  "page": 5,
//  "total_results": 10000,
//  "total_pages": 500,
//  "results": [
//    {
//      "popularity": 39.823,
//      "vote_count": 10469,
//      "video": false,
//      "poster_path": "/eFnGmj63QPUpK7QUWSOUhypIQOT.jpg",
//      "id": 109445,
//      "adult": false,
//      "backdrop_path": "/cN9Nbwh66TRcj2gBE8cSEZulsx3.jpg",
//      "original_language": "en",
//      "original_title": "Frozen",
//      "genre_ids": [
//        12,
//        16,
//        10751
//      ],
//      "title": "Frozen",
//      "vote_average": 7.3,
//      "overview": "Young princess Anna of Arendelle dreams about finding true love at her sister Elsa’s coronation. Fate takes her on a dangerous journey in an attempt to end the eternal winter that has fallen over the kingdom. She's accompanied by ice delivery man Kristoff, his reindeer Sven, and snowman Olaf. On an adventure where she will find out what friendship, courage, family, and true love really means.",
//      "release_date": "2013-11-27"
//    }
//  ]
//}
