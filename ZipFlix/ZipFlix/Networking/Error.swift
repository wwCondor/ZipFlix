//
//  Error.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum MovieDBError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case noData
    case responseUnsuccessful
    case jsonParsingFailure
    case jsonDecodingFailure
    case invalidUrl
    case missingKey
    case noReachability
    case noResults
}

extension MovieDBError: LocalizedError {
    var description: String {
        switch self {
        case .requestFailed:         return "Request Failed"
        case .invalidData:           return "Invalid Data"
        case .noData:                return "No Data"
        case .responseUnsuccessful:  return "Response Unsuccessful"
        case .jsonParsingFailure:    return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .jsonDecodingFailure:   return "JSON Decoding Failure"
        case .invalidUrl:            return "Invalid URL"
        case .missingKey:            return "Please set your key in APIkey.swift"
        case .noReachability:        return "Check connection and try again"
        case .noResults:             return "Page did not contain results"
        }
    }
}

enum UserSelectionError: Error {
    case genreSelection
    case personSelection
    case ratingSelection
}

extension UserSelectionError: LocalizedError {
    var description: String {
        switch self {
            case .genreSelection:   return "Please select at least one genre for both sides"
            case .personSelection:  return "Please select a person for both sides"
            case .ratingSelection:  return "Please select a minimum rating for both sides"
        }

    }
}
