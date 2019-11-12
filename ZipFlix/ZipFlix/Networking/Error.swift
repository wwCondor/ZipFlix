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
    case responseUnsuccessful(statuscode: Int)
    case invalidData
    case jsonConversionFailure(message: String)
    case invalidUrl
    case jsonParsingFailure(message: String)
}

extension MovieDBError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .responseUnsuccessful: return "Response Unsuccesful"
        case .invalidData: return "Invalid Data"
        case .jsonConversionFailure: return "JSON Conversion Failed"
        case .invalidUrl: return "Invalid URL"
        case .jsonParsingFailure: return "JSON Parsing Failed"
        }
    }
}
