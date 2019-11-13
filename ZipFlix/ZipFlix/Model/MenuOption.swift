//
//  MenuOption.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct MenuOption: Equatable {
    let genre: MovieGenre
    let id: Int
    var selected: Bool
}


enum MovieGenre {
    case action
    case adventure
    case animation
    case comedy
    case crime
    case documentary
    case drama
    case family
    case fantasy
    case history
    case horror
    case music
    case mystery
    case romance
    case scienceFiction
    case tvMovie
    case thriller
    case war
    case western
    
    var string: String {
        switch self {
        case .action:           return "Action"
        case .adventure:        return "Adventure"
        case .animation:        return "Animation"
        case .comedy:           return "Comedy"
        case .crime:            return "Crime"
        case .documentary:      return "Documentary"
        case .drama:            return "Drama"
        case .family:           return "Family"
        case .fantasy:          return "Fantasy"
        case .history:          return "History"
        case .horror:           return "Horror"
        case .music:            return "Music"
        case .mystery:          return "Mystery"
        case .romance:          return "Romance"
        case .scienceFiction:   return "Science Fiction"
        case .tvMovie:          return "TV Movie"
        case .thriller:         return "Thriller"
        case .war:              return "War"
        case .western:          return "Western"

        }
    }
}

//enum Backup {
//    case action
//    case adventure
//    case animation
//    case children
//    case christmas
//    case comedy
//    case documentary
//    case drama
//    case foreign
//    case music
//    case horror
//    case LGBTQ
//    case romance
//    case scienceFictionAndFantasy
//    case thriller
//    case war
//    case western
//    
//    var string: String {
//        switch self {
//        case .action:                   return "Action"
//        case .adventure:                return "Adventure"
//        case .animation:                return "Animation"
//        case .children:                 return "Children & Family"
//        case .comedy:                   return "Comedy"
//        case .christmas:                return "Christmas"
//        case .documentary:              return "Documentary"
//        case .drama:                    return "Drama"
//        case .foreign:                  return "Foreign"
//        case .horror:                   return "Horror"
//        case .music:                    return "Music"
//        case .LGBTQ:                    return "LGBTQ"
//        case .romance:                  return "Romance"
//        case .scienceFictionAndFantasy: return "Science Fiction & Fantasy"
//        case .thriller:                 return "Thriller"
//        case .western:                  return "Western"
//        case .war:                      return "War"
//
//        }
//    }
//}
