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

    static func getAllPages<T>(url: URL, pages: [Page<T>], completionHandler completion: @escaping ([Page<T>]?, Error?) -> Void) {
        var allpages = pages
        let maxPages: Int = 50
        
        PageHandler.getPage(url: url) { (page: Page<T>?, error: Error?) in
            var currentPage: Int = 1
            
            if let page = page {
                allpages.append(page)
                // Only if current page != total pages AND != max pages we increase currentPage by 1
                if currentPage != page.totalPages && currentPage != maxPages {
                    currentPage += 1
                     
                    let nextPageUrl = Endpoint.people.url(page: currentPage)
                    
                    PageHandler.getAllPages(url: nextPageUrl, pages: allpages, completionHandler: completion)
                    // If eiter condition mentioned above is met we should not try to obtaind another page
                } else {
                    completion(allpages, nil)
                }
            } else if let error = error {
                print(error)
                completion(nil, error)
            }
            
        }
    }
    
    static func getPage<T>(url: URL, completionHandler completion: @escaping (Page<T>?, Error?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let task = PageHandler.session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, MovieDBError.requestFailed)
                        return
                    }
                    
                    if 200...299 ~= httpResponse.statusCode {
                        //                        print("Status Code: \(httpResponse.statusCode)")
                        
                        do {
                            let results = try PageHandler.decoder.decode(Page<T>.self, from: data)
                            //                            print(results)
                            completion(results, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                        
                    } else {
                        completion(nil, MovieDBError.invalidData)
                    }
                    
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
