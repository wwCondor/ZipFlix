//
//  MenuOption.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct MenuOption {
    var genre: MovieGenre
    var selected: Bool
}

enum MovieGenre {
    case action
    case adventure
    case animation
    case children
    case christmas
    case comedy
    case documentary
    case drama
    case foreign
    case music
    case horror
    case LGBTQ
    case romance
    case scienceFictionAndFantasy
    case thriller
    case war
    case western
    
    var string: String {
        switch self {
        case .action:                   return "Action"
        case .adventure:                return "Adventure"
        case .animation:                return "Animation"
        case .children:                 return "Children & Family"
        case .comedy:                   return "Comedy"
        case .christmas:                return "Christmas"
        case .documentary:              return "Documentary"
        case .drama:                    return "Drama"
        case .foreign:                  return "Foreign"
        case .horror:                   return "Horror"
        case .music:                    return "Music"
        case .LGBTQ:                    return "LGBTQ"
        case .romance:                  return "Romance"
        case .scienceFictionAndFantasy: return "Science Fiction & Fantasy"
        case .thriller:                 return "Thriller"
        case .western:                  return "Western"
        case .war:                      return "War"

        }
    }
}
