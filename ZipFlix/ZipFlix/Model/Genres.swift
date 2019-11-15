//
//  Genres.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]?
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}
