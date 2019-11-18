//
//  People.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Person: Codable, Equatable {
    let popularity: Double?             // 26.359
    let knownForDepartment: String?  // "Acting"
    let gender: Int?                 // 2
    let id: Int?                     // 1449329
    let profilePath: String?        // "/m436jpgrrxmBTUdKSiWPsVRLxpW.jpg"
    let adult: Bool?                 // false
    let name: String?                // "Jack Bannon"
}

//struct Media: Codable, Equatable {
//    let releaseDate: String?
//    let id: Int?
//    let voteCount: Int?
//    let video: Bool?
//    let mediaType: String?
//    let voteAverage: Double?
//    let title: String?
//    let genreIds: [Int]? //probably
//    let originalTitle: String?
//    let originalLanguage: String?
//    let adult: Bool? // maybe
//    let backdropPath: String?
//    let overview: String
//    let posterPath: String? //dimension: 500x750
//}



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
 
 [
 {
     "popularity": 29.108,
     "known_for_department": "Acting",
     "gender": 2,
     "id": 1449329,
     "profile_path": "/m436jpgrrxmBTUdKSiWPsVRLxpW.jpg",
     "adult": false,
     "known_for": [
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
         },
         {
             "release_date": "2014-10-15",
             "id": 228150,
             "vote_count": 7081,
             "video": false,
             "media_type": "movie",
             "vote_average": 7.4,
             "title": "Fury",
             "genre_ids": [
                 28,
                 18,
                 10752
             ],
             "original_title": "Fury",
             "original_language": "en",
             "adult": false,
             "backdrop_path": "/pKawqrtCBMmxarft7o1LbEynys7.jpg",
             "overview": "In the last months of World War II, as the Allies make their final push in the European theatre, a battle-hardened U.S. Army sergeant named 'Wardaddy' commands a Sherman tank called 'Fury' and its five-man crew on a deadly mission behind enemy lines. Outnumbered and outgunned, Wardaddy and his men face overwhelming odds in their heroic attempts to strike at the heart of Nazi Germany.",
             "poster_path": "/fa4PxEPRKWRyjzYje1jM4m30qzd.jpg"
         },
         {
             "original_name": "Endeavour",
             "vote_count": 86,
             "poster_path": "/nMDKyd3WF7TRKuW5Z0kUTs7VQ6d.jpg",
             "media_type": "tv",
             "name": "Endeavour",
             "vote_average": 8.1,
             "id": 44264,
             "first_air_date": "2012-01-02",
             "original_language": "en",
             "genre_ids": [
                 80,
                 18,
                 9648
             ],
             "backdrop_path": "/mu2gbaggjfRQxIbghD4npclUULr.jpg",
             "overview": "The early days of a young Endeavour Morse, whose experiences as a detective constable with the Oxford City Police will ultimately shape his future.",
             "origin_country": [
                 "GB"
             ]
         }
     ],
     "name": "Jack Bannon"
 }
 ]
 
 */


