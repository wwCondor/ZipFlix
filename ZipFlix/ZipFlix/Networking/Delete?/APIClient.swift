//
//  APIClient.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation


protocol APIClient {
    var session: URLSession { get }

    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, MovieDBError>) -> Void)
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], MovieDBError>) -> Void)
}

extension APIClient {
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, MovieDBError?) -> Void
    
    // The method here takes a request and then defines a completion handler for the callback. It then returns the dataTask.
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        // With that request we are going to create a dataTask and define the body of the calback
        let task = session.dataTask(with: request) { data, response, error in
            
            // Here we cast the response to an httpResponse
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            // We are going to inspect the status code and make sure it is ok (200)
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        
        // Here we return the task (Note: we do not call resume here. We will do that later)
        return task
    }
    
    // Note: Constraining the generic parameter in the fetch method to conform to JSONDecodable, means that in the parse argument we are guaranteed a way to convert to the desired model from JSON
    
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> T?, completion: @escaping (Result<T, MovieDBError>) -> Void) {
        // First we use the request passed in as an argument to download some JSON
        let task = jsonTask(with: request) { json, error in
            // Since we are done with the work in the background queueu we switch the to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        // Since there is no JSON inside the guard statement, this is a failure case
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }

                    return
                }

                // Here we are going to call the parse function and pass in the JSON we've just unwrapped
                if let value = parse(json) {
                    // In here we have everything we need for our success path
                    completion(.success(value))

                    // Since we are using an "if let" we could end up with a nil value form the parse function
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }

        task.resume()
    }
    
    
    func fetch<T: JSONDecodable>(with request: URLRequest, parse: @escaping (JSON) -> [T], completion: @escaping (Result<[T], MovieDBError>) -> Void) {
        // First we use the request passed in as an argument to download some JSON
        let task = jsonTask(with: request) { json, error in
            // Since we are done with the work in the background queueu we switch the to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        // Since there is no JSON inside the guard statement, this is a failure case
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    
                    return
                }
                
                let value = parse(json)
                // Since it is an array we dont need an if let to take account for an optional
                
                // If value if not empty (!value = empty: means value contains data)
                if !value.isEmpty {
                    // In here we have everything we need for our success path
                    completion(.success(value))
                    
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        
        task.resume()
        
    }

    
}

