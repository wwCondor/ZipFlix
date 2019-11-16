//
//  PageHandler.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 14/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class PageHandler {
    // Object that handles downloading pages of data for popular people and movies
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    static let session = URLSession(configuration: .default)
    
    static func getAllPages<T>(pages: [Page<T>], completionHandler completion: @escaping ([Page<T>]?, Error?) -> Void) {
        var allpages = pages
        let maxPages = 5
        var currentPage = 1
        let nextPageUrl = Endpoint.people.url(page: currentPage)
        
        PageHandler.getPage(url: nextPageUrl) { (page: Page<T>?, error: Error?) in
            
            if let page = page {
                currentPage += 1
                allpages.append(page)
                
                let totalPages = page.totalPages
                
                if currentPage == totalPages || currentPage == maxPages {
                    completion(allpages, nil)
                } else {
                    print(currentPage)
                    PageHandler.getAllPages(pages: allpages, completionHandler: completion)
                }
            } else if let error = error {
                print("We are here, with error: \(error)")
                completion(nil, error)
            }
        }
    }
    
    static func getPage<T>(url: URL, completionHandler completion: @escaping (Page<T>?, Error?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let task = PageHandler.session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, MovieDBError.requestFailed)
                    return
                }
                
                if 200...299 ~= httpResponse.statusCode {
                    print("Status Code: \(httpResponse.statusCode)")
                    if let data = data {
                        print(data)
                        
                        do {
                            let results = try self.decoder.decode(Page<T>.self, from: data)
//                            print(results)
                            completion(results, nil)
                            
                        } catch let error {
                            print("Error Exit 4")
                            completion(nil, error)
                        }

                    } else if let error = error {
                        print("Error Exit 5")
                        completion(nil, error)
                    }
                } else {
                    print("Status Code: \(httpResponse.statusCode)")
                    completion(nil, MovieDBError.invalidData)
                }
            }
        }
        task.resume()
    }
}
















//    static func getPage<T>(url: URL, completionHandler completion: @escaping (Page<T>?, Error?) -> Void) {
//
//        let request = URLRequest(url: url)
//
//        let task = PageHandler.session.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    print(data)
//
//                    guard let httpResponse = response as? HTTPURLResponse else {
//                        completion(nil, MovieDBError.requestFailed)
//                        return
//                    }
//
//                    if 200...299 ~= httpResponse.statusCode {
//                        //                        print("Status Code: \(httpResponse.statusCode)")
//
//                        do {
////                            let value = String(decoding: data, as: UTF8.self)
////                            let filteredValues = value.replacingOccurrences(of: ".", with: "", options: .regularExpression)
////                            guard let newData: Data = filteredValues.data(using: .utf8) else {
////                                print("Data filtering error")
////                                return
////                            }
//
//                            let results = try PageHandler.decoder.decode(Page<T>.self, from: data)
//                            print(results)
//                            completion(results, nil)
//                        } catch let error {
//                            print("Error Exit 4")
//                            completion(nil, error)
//                        }
//
//                    } else {
//                        completion(nil, MovieDBError.invalidData)
//                    }
//
//                } else if let error = error {
//                    print("Error Exit 5")
//                    completion(nil, error)
//                }
//            }
//        }
//        task.resume()
//    }
