//
//  Result.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// Generics (This one is generic over two types)
// With generic code we can write reusable functions and data types that can work with any type that matches the constraints we define. The aim is to factor out shared functionality and reduce boilerplate code.
// It has a constraint for U: must be a type that conforms to an error protocol
enum Result<T, U> where U: Error {
    // In here we have two values to model the type of result that we can get
    // Since we want a model populated with the data that we requested
    case success(T)
    case failure(U)
    
}
