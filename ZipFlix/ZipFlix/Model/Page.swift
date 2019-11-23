//
//  Page.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 12/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Page<T: Codable>: Codable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [T]?
}
