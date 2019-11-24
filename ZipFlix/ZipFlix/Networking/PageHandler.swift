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
    
    static func getPages<T>(url: URL, pages: [Page<T>], completion: @escaping ([Page<T>]?, Error?) -> Void) {
        var allpages = pages
        let maxPages: Int = 5
        
        PageHandler.getPage(url: url) { (page: Page<T>?, error: Error?) in
            if let page = page {
                guard let currentPage = page.page else {
                    print("Page does not contain value for current Page")
                    return
                }
                
                allpages.append(page)
                
                if currentPage == page.totalPages || currentPage == maxPages {
                    completion(allpages, nil)
                } else {
                    let nextPage = currentPage + 1
                    let nextUrl = Endpoint.people.url(page: nextPage)
                    PageHandler.getPages(url: nextUrl, pages: allpages, completion: completion)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
    
    static func getPage<T>(url: URL, completion: @escaping (Page<T>?, Error?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let task = PageHandler.session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, MovieDBError.requestFailed)
                    return
                }
                if 200...299 ~= httpResponse.statusCode {
                    if let data = data {
                        
                        do {
                            let results = try self.decoder.decode(Page<T>.self, from: data)
                            completion(results, nil)
                            
                        } catch { // let error {
//                            print("Error Exit 4")
//                            print(data)
//                            print(error)
                            completion(nil, MovieDBError.jsonDecodingFailure)
                        }

                    } else if let error = error {
                        completion(nil, error)
                    }
                } else {
                    completion(nil, MovieDBError.invalidData)
                }
            }
        }
        task.resume()
    }
}
