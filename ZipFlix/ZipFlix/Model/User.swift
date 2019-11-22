//
//  User.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 20/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct User {
    var selectedGenres: [Genre]
    var selectedPersons: [Person]
    var selectedRating: Double
    
    static var leftUser = User(selectedGenres: [], selectedPersons: [], selectedRating: 0.0)
    static var rightUser = User(selectedGenres: [], selectedPersons: [], selectedRating: 0.0)
    
    private static func getGenres(for leftUser: User, and rigthUser: User) -> [Genre] {
        // Combine all genres preventing doubles
        var allGenres: [Genre] = [Genre]()

        for genre in leftUser.selectedGenres {
            if !allGenres.contains(genre) {
                allGenres.append(genre)
            }
        }
        for genre in rigthUser.selectedGenres {
            if !allGenres.contains(genre) {
                allGenres.append(genre)
            }
        }
        print("Combined genres: \(allGenres)")
        return allGenres
    }
    
    static func getGenreIds() -> String {
        // To ensure discovery and prevent repetition for same selections we shuffle totalGenres and select a max of 3
        let genres = getGenres(for: leftUser, and: rightUser).shuffled()
        let maxGenresReturned = 3
        var currentGenre = 0
        
        var genreIds = ""
        
        for genre in genres {
            if currentGenre != maxGenresReturned || currentGenre != genres.count {
                guard let genreId = genre.id else {
                    return ""
                }
                genreIds += String(describing: genreId) + "|"
                currentGenre += 1
            } else {
                print("Max genres reached or only 2 available")
            }
        }
        print("GenreIds: \(genreIds)")
        return genreIds
    }
    
    static func getPersons(for user: User) -> String {
        var personIds = ""
        for person in user.selectedPersons {
            guard let personId = person.id else {
                return ""
            }
            personIds += String(describing: personId) + "|"
        }
        print("PersonId: \(personIds)")
        return personIds
    }
    
    // Should we round this as well
    static func getAverageRating() -> Double {
        let leftUserRating = User.leftUser.selectedRating
        let rightUserRating = User.rightUser.selectedRating
        let roundedAverage = Double(round((leftUserRating + rightUserRating)/2 * 10))/10
        print("Average rating: \(roundedAverage)")
        return roundedAverage
    }
}
