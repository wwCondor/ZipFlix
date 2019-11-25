//
//  People.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Person: Codable, Equatable {
    let popularity: Double?
    let knownForDepartment: String?
    let gender: Int?
    let id: Int?
    let profilePath: String?
    let adult: Bool?
    let name: String?                
}
