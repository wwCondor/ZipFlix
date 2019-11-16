//
//  Movie.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    let releaseDate: String?
    let id: Int?
    let voteCount: Int?
    let video: Bool?
    let mediaType: String?
    let voteAverage: Double?
    let title: String?
    let genreIds: [Int]? //probably
    let originalTitle: String?
    let originalLanguage: String?
    let adult: Bool? // maybe
    let backdropPath: String?
    let overview: String
    let posterPath: String? //dimension: 500x750

//    let popularity: Int? //maybe?
    
}

/*
 {
     "release_date": "2014-11-14",
     "id": 205596,
     "vote_count": 11053,
     "video": false,
     "media_type": "movie",
     "vote_average": 8.1,
     "title": "The Imitation Game",
     "genre_ids": [
         18,
         36,
         53,
         10752
     ],
     "original_title": "The Imitation Game",
     "original_language": "en",
     "adult": false,
     "backdrop_path": "/qcb6z1HpokTOKdjqDTsnjJk0Xvg.jpg",
     "overview": "Based on the real life story of legendary cryptanalyst Alan Turing, the film portrays the nail-biting race against time by Turing and his brilliant team of code-breakers at Britain's top-secret Government Code and Cypher School at Bletchley Park, during the darkest days of World War II.",
     "poster_path": "/noUp0XOqIcmgefRnRZa1nhtRvWO.jpg"
 }
 
 */

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
