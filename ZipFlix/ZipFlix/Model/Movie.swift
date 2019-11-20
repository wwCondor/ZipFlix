//
//  Movie.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
//    let popularity: Int? //maybe?
//    let voteCount: Int?
//    let video: Bool?
    let posterPath: String? //dimension: 500x750
//    let id: Int?
//    let adult: Bool? // maybe
//    let backdropPath: String?
    let originalLanguage: String?
//    let originalTitle: String?
    let genreIds: [Int]? //probably
    let title: String?
    let voteAverage: Double?
    let overview: String?
    let releaseDate: String?
}

struct TestMovie {
    let posterPath: String?
    let originalLanguage: String?
    let genreIds: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview: String
    let releaseDate: String?
}

/*
 {
   "popularity": 37.11,
   "vote_count": 7096,
   "video": false,
   "poster_path": "/fa4PxEPRKWRyjzYje1jM4m30qzd.jpg",
   "id": 228150,
   "adult": false,
   "backdrop_path": "/pKawqrtCBMmxarft7o1LbEynys7.jpg",
   "original_language": "en",
   "original_title": "Fury",
   "genre_ids": [
     28,
     18,
     10752
   ],
   "title": "Fury",
   "vote_average": 7.4,
   "overview": "In the last months of World War II, as the Allies make their final push in the European theatre, a battle-hardened U.S. Army sergeant named 'Wardaddy' commands a Sherman tank called 'Fury' and its five-man crew on a deadly mission behind enemy lines. Outnumbered and outgunned, Wardaddy and his men face overwhelming odds in their heroic attempts to strike at the heart of Nazi Germany.",
   "release_date": "2014-10-15"
 }
 
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
 
 */


