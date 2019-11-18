//
//  PeopleDataManager.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 15/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class PeopleDataManager {
    
    typealias PersonCompletionHandler = ([Person]?, Error?) -> Void
    typealias PeoplePagesCompletionHandler = ([Page<Person>]?, Error?) -> Void

    static func fetchPopularPeople(completion: @escaping PersonCompletionHandler) {
        var allPeople = [Person]()
                getPeoplePages { (peoplePages, error) in
                    // first we check wether have pages
                    if let peoplePages = peoplePages {
                        // If we have pages we check for each page if it contains results
                        for peoplePage in peoplePages {
                            guard let peopleArray = peoplePage.results else {
                                print("Unable to obtain people array from pages")
                                completion(nil, error)
                                return
                            }
                            // If it does, each character inside results will be added to an array
                            for person in peopleArray {
                                var peopleDuplicates = [Person]()
                                if !allPeople.contains(person) {
                                    allPeople.append(person)
//                                    print("***")
//                                    print("\(String(describing: person.name)) added to array; total: \(allPeople.count)")
                                } else {
                                    peopleDuplicates.append(person)
                                }
                            }
                            completion(allPeople, nil)
                        }
                    } else if let error = error {
                        print(error)
                        completion(nil, error)
                    }
                }
    }
    
    static func getPeoplePages(completion: @escaping PeoplePagesCompletionHandler) {
        let url = Endpoint.people.url(page: 1) // First page is always 1
        let allpages = [Page<Person>]()
        PageHandler.getPages(url: url, pages: allpages, completion: completion)
    }
    
}
