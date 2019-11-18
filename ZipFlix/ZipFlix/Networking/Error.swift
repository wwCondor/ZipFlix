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
    case responseUnsuccessful
    case jsonParsingFailure
    case jsonDecodingFailure
    case invalidUrl
    case missingKey
}

extension MovieDBError: LocalizedError {
    var description: String {
        switch self {
        case .requestFailed:         return "Request Failed"
        case .invalidData:           return "Invalid Data"
        case .responseUnsuccessful:  return "Response Unsuccessful"
        case .jsonParsingFailure:    return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .jsonDecodingFailure:   return "JSON Decoding Failure"
        case .invalidUrl:            return "Invalid URL"
        case .missingKey:            return "Please set your key in APIkey.swift"
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
            case .genreSelection:   return "Left and/or right user still needs to select at least one genre"
            case .personSelection:  return "Left and/or right user still needs to select one person"
            case .ratingSelection:    return "Left and/or right user still needs to select a minimum rating"
        }

    }
}
