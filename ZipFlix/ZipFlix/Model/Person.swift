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
