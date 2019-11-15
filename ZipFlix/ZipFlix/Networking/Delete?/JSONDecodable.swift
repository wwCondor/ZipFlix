//
//  JSONDecodable.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

/*
 Instantiates an instance of the conforming type with a JSON dictionary
 
 Return 'nil' if the JSON dictionary does not contain all the values need for instantiation of the conforming type
 */

protocol JSONDecodable {
    init?(josn: [String: Any])
}
