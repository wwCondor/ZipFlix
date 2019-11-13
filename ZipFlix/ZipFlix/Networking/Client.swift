//
//  Client.swift
//  ZipFlix
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class Client {
    
    fileprivate static let apiKey: String = "ed3e128599234a1dca2c7d4787238741"
    
//    lazy var baseUrl: URL = {
//        return URL(string: "https://api.themoviedb.org/3/movie/550?api_key=\(self.apiKey)")!
//    }()
    
    static let baseUrl: URL = {
        return URL(string:"https://api.themoviedb.org/3/")!
    }()
    
//    static let genreUrl: URL = {
//       return URL(string: "genre/movie/list?api_key=\(apiKey)", relativeTo: baseUrl)!
//    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    static let session = URLSession(configuration: .default)
    
    
    // Method that obtains all genres
    static func getGenres(completion: @escaping (Genres?, Error?) -> Void) {
        
        guard let url = URL(string: "genre/movie/list?api_key=\(apiKey)", relativeTo: baseUrl) else {
            completion(nil, MovieDBError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = Client.session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, MovieDBError.requestFailed)
                        return
                    }
                    
                    if 200...299 ~= httpResponse.statusCode {
                        print("Status Code: \(httpResponse.statusCode)")
                        
                        do {
                            let results = try Client.decoder.decode(Genres.self, from: data)
                            completion(results, nil)
                            
                        } catch let error {
                            completion(nil, MovieDBError.jsonConversionFailure(description: "\(error.localizedDescription)"))
                        }
                        
                    } else {
                        completion(nil, MovieDBError.responseUnsuccessful(description: "Status code: \(httpResponse.statusCode)"))
                    }
                    
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    // Steps
    // 1. Construct API call that obtains the genre data
    // 2. Parse JSON (need model)
    // 3.
    //
    //
    //
    //
    
}




/*
Example response for genres
 {
     "genres": [
         {
             "id": 28,
             "name": "Action"
         },
         {
             "id": 12,
             "name": "Adventure"
         },
         {
             "id": 16,
             "name": "Animation"
         },
         {
             "id": 35,
             "name": "Comedy"
         },
         {
             "id": 80,
             "name": "Crime"
         },
         {
             "id": 99,
             "name": "Documentary"
         },
         {
             "id": 18,
             "name": "Drama"
         },
         {
             "id": 10751,
             "name": "Family"
         },
         {
             "id": 14,
             "name": "Fantasy"
         },
         {
             "id": 36,
             "name": "History"
         },
         {
             "id": 27,
             "name": "Horror"
         },
         {
             "id": 10402,
             "name": "Music"
         },
         {
             "id": 9648,
             "name": "Mystery"
         },
         {
             "id": 10749,
             "name": "Romance"
         },
         {
             "id": 878,
             "name": "Science Fiction"
         },
         {
             "id": 10770,
             "name": "TV Movie"
         },
         {
             "id": 53,
             "name": "Thriller"
         },
         {
             "id": 10752,
             "name": "War"
         },
         {
             "id": 37,
             "name": "Western"
         }
     ]
 }
 
 */

class Test {
    
    fileprivate let apiKey: String = "ed3e128599234a1dca2c7d4787238741"
    
    
    // The url that obtains all the genres
    lazy var genreUrl: URL = {
        return URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(self.apiKey)")!
    }()
    
    
    lazy var testURL: URL = {
        return URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(self.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=5")!
    }()
}

/*
 
 Example response for discover:
 
 https://api.themoviedb.org/3/discover/movie?api_key=ed3e128599234a1dca2c7d4787238741&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=5
 
 https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg // image URL for movie for poster_path
 
 {
   "page": 5,
   "total_results": 10000,
   "total_pages": 500,
   "results": [
     {
       "popularity": 39.823,
       "vote_count": 10469,
       "video": false,
       "poster_path": "/eFnGmj63QPUpK7QUWSOUhypIQOT.jpg",
       "id": 109445,
       "adult": false,
       "backdrop_path": "/cN9Nbwh66TRcj2gBE8cSEZulsx3.jpg",
       "original_language": "en",
       "original_title": "Frozen",
       "genre_ids": [
         12,
         16,
         10751
       ],
       "title": "Frozen",
       "vote_average": 7.3,
       "overview": "Young princess Anna of Arendelle dreams about finding true love at her sister Elsa’s coronation. Fate takes her on a dangerous journey in an attempt to end the eternal winter that has fallen over the kingdom. She's accompanied by ice delivery man Kristoff, his reindeer Sven, and snowman Olaf. On an adventure where she will find out what friendship, courage, family, and true love really means.",
       "release_date": "2013-11-27"
     },
     {
       "popularity": 38.275,
       "vote_count": 12486,
       "video": false,
       "poster_path": "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg",
       "id": 284053,
       "adult": false,
       "backdrop_path": "/kaIfm5ryEOwYg8mLbq8HkPuM1Fo.jpg",
       "original_language": "en",
       "original_title": "Thor: Ragnarok",
       "genre_ids": [
         28,
         12,
         35,
         14
       ],
       "title": "Thor: Ragnarok",
       "vote_average": 7.5,
       "overview": "Thor is imprisoned on the other side of the universe and finds himself in a race against time to get back to Asgard to stop Ragnarok, the destruction of his home-world and the end of Asgardian civilization, at the hands of an all-powerful new threat, the ruthless Hela.",
       "release_date": "2017-11-03"
     },
     {
       "popularity": 35.911,
       "vote_count": 17441,
       "video": false,
       "poster_path": "/adw6Lq9FiC9zjYEpOqfq03ituwp.jpg",
       "id": 550,
       "adult": false,
       "backdrop_path": "/mMZRKb3NVo5ZeSPEIaNW9buLWQ0.jpg",
       "original_language": "en",
       "original_title": "Fight Club",
       "genre_ids": [
         18
       ],
       "title": "Fight Club",
       "vote_average": 8.4,
       "overview": "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
       "release_date": "1999-10-15"
     },
     {
       "popularity": 61.334,
       "vote_count": 13176,
       "video": false,
       "poster_path": "/tkt9xR1kNX5R9rCebASKck44si2.jpg",
       "id": 22,
       "adult": false,
       "backdrop_path": "/8AUQ7YlJJA9C8kWk8P4YNHIcFDE.jpg",
       "original_language": "en",
       "original_title": "Pirates of the Caribbean: The Curse of the Black Pearl",
       "genre_ids": [
         28,
         12,
         14
       ],
       "title": "Pirates of the Caribbean: The Curse of the Black Pearl",
       "vote_average": 7.7,
       "overview": "Jack Sparrow, a freewheeling 18th-century pirate, quarrels with a rival pirate bent on pillaging Port Royal. When the governor's daughter is kidnapped, Sparrow decides to help the girl's love save her.",
       "release_date": "2003-07-09"
     },
     {
       "popularity": 34.089,
       "vote_count": 10612,
       "video": false,
       "poster_path": "/sM33SANp9z6rXW8Itn7NnG1GOEs.jpg",
       "id": 269149,
       "adult": false,
       "backdrop_path": "/mhdeE1yShHTaDbJVdWyTlzFvNkr.jpg",
       "original_language": "en",
       "original_title": "Zootopia",
       "genre_ids": [
         12,
         16,
         35,
         10751
       ],
       "title": "Zootopia",
       "vote_average": 7.7,
       "overview": "Determined to prove herself, Officer Judy Hopps, the first bunny on Zootopia's police force, jumps at the chance to crack her first case - even if it means partnering with scam-artist fox Nick Wilde to solve the mystery.",
       "release_date": "2016-03-04"
     },
     {
       "popularity": 45.258,
       "vote_count": 10751,
       "video": false,
       "poster_path": "/9gLu47Zw5ertuFTZaxXOvNfy78T.jpg",
       "id": 177572,
       "adult": false,
       "backdrop_path": "/wXBCE6sS94zb8IlnQ51OPApgfhC.jpg",
       "original_language": "en",
       "original_title": "Big Hero 6",
       "genre_ids": [
         28,
         12,
         16,
         35,
         10751
       ],
       "title": "Big Hero 6",
       "vote_average": 7.8,
       "overview": "The special bond that develops between plus-sized inflatable robot Baymax, and prodigy Hiro Hamada, who team up with a group of friends to form a band of high-tech heroes.",
       "release_date": "2014-11-07"
     },
     {
       "popularity": 27.836,
       "vote_count": 7039,
       "video": false,
       "poster_path": "/or1MP8BZIAjqWYxPdPX724ydKar.jpg",
       "id": 14,
       "adult": false,
       "backdrop_path": "/z5J18ByLeOZ68iORfMXmxeFuwyL.jpg",
       "original_language": "en",
       "original_title": "American Beauty",
       "genre_ids": [
         18
       ],
       "title": "American Beauty",
       "vote_average": 8,
       "overview": "Lester Burnham, a depressed suburban father in a mid-life crisis, decides to turn his hectic life around after developing an infatuation with his daughter's attractive friend.",
       "release_date": "1999-09-15"
     },
     {
       "popularity": 38.549,
       "vote_count": 12876,
       "video": false,
       "poster_path": "/c24sv2weTHPsmDa7jEMN0m2P3RT.jpg",
       "id": 315635,
       "adult": false,
       "backdrop_path": "/vc8bCGjdVp0UbMNLzHnHSLRbBWQ.jpg",
       "original_language": "en",
       "original_title": "Spider-Man: Homecoming",
       "genre_ids": [
         28,
         12,
         18,
         878
       ],
       "title": "Spider-Man: Homecoming",
       "vote_average": 7.4,
       "overview": "Following the events of Captain America: Civil War, Peter Parker, with the help of his mentor Tony Stark, tries to balance his life as an ordinary high school student in Queens, New York City, with fighting crime as his superhero alter ego Spider-Man as a new threat, the Vulture, emerges.",
       "release_date": "2017-07-07"
     },
     {
       "popularity": 33.301,
       "vote_count": 20888,
       "video": false,
       "poster_path": "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
       "id": 24428,
       "adult": false,
       "backdrop_path": "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
       "original_language": "en",
       "original_title": "The Avengers",
       "genre_ids": [
         28,
         12,
         878
       ],
       "title": "The Avengers",
       "vote_average": 7.7,
       "overview": "When an unexpected enemy emerges and threatens global safety and security, Nick Fury, director of the international peacekeeping agency known as S.H.I.E.L.D., finds himself in need of a team to pull the world back from the brink of disaster. Spanning the globe, a daring recruitment effort begins!",
       "release_date": "2012-05-04"
     },
     {
       "popularity": 25.008,
       "vote_count": 9554,
       "video": false,
       "poster_path": "/9skUuHTFtsJznuFPwmB17ZZvq09.jpg",
       "id": 6479,
       "adult": false,
       "backdrop_path": "/u6Qg7TH7Oh1IFWCQSRr4htFFt0A.jpg",
       "original_language": "en",
       "original_title": "I Am Legend",
       "genre_ids": [
         28,
         18,
         27,
         878,
         53
       ],
       "title": "I Am Legend",
       "vote_average": 7.1,
       "overview": "Robert Neville is a scientist who was unable to stop the spread of the terrible virus that was incurable and man-made. Immune, Neville is now the last human survivor in what is left of New York City and perhaps the world. For three years, Neville has faithfully sent out daily radio messages, desperate to find any other survivors who might be out there. But he is not alone.",
       "release_date": "2007-12-14"
     },
     {
       "popularity": 34.65,
       "vote_count": 57,
       "video": false,
       "poster_path": "/fjmMu9fpqMMF17mCyLhNfkagKB0.jpg",
       "id": 578189,
       "adult": false,
       "backdrop_path": "/zBAoNL50oFRCAJvEEQEKD8M48pV.jpg",
       "original_language": "en",
       "original_title": "Black and Blue",
       "genre_ids": [
         28,
         80,
         18
       ],
       "title": "Black and Blue",
       "vote_average": 5,
       "overview": "Exposure follows a rookie Detroit African-American female cop who stumbles upon corrupt officers who are murdering a drug dealer, an incident captured by her body cam. They pursue her through the night in an attempt to destroy the footage, but to make matters worse, they've tipped off a criminal gang that she's responsible for the dealer's death.",
       "release_date": "2019-10-25"
     },
     {
       "popularity": 32.089,
       "vote_count": 0,
       "video": false,
       "poster_path": "/4zmIbm4LArnXJ2U1EPiCpA1pJ9K.jpg",
       "id": 582083,
       "adult": false,
       "backdrop_path": "/lSQjKTyW5tS0uiIXnlIe3hFlq6T.jpg",
       "original_language": "ja",
       "original_title": "仮面ライダービルドNEW WORLD　仮面ライダーグリス",
       "genre_ids": [
         28,
         12,
         878
       ],
       "title": "Kamen Rider Build NEW WORLD: Kamen Rider Grease",
       "vote_average": 0,
       "overview": "Deputy Officer of the United Nations Alliance, Simon Marcus, who aims to conquer the world with the terrorist organization Downfall along with the mad scientist Keiji Uraga, attack the Kamen Riders with overwhelming strength. It is only on Kamen Rider Grease that the enemy's abilities did not work. In order to defeat this new enemy and rescue Misora, Kazumi Sawatari must create a new item ... but it is told that it requires the  life of his friends, the Three Crows. The ultimate decision must be made.",
       "release_date": "2019-11-27"
     },
     {
       "popularity": 38.171,
       "vote_count": 7300,
       "video": false,
       "poster_path": "/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg",
       "id": 335984,
       "adult": false,
       "backdrop_path": "/8QXGNP0Vb4nsYKub59XpAhiUSQN.jpg",
       "original_language": "en",
       "original_title": "Blade Runner 2049",
       "genre_ids": [
         18,
         878
       ],
       "title": "Blade Runner 2049",
       "vote_average": 7.4,
       "overview": "Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what's left of society into chaos. K's discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.",
       "release_date": "2017-10-06"
     },
     {
       "popularity": 46.008,
       "vote_count": 3750,
       "video": false,
       "poster_path": "/xRWht48C2V8XNfzvPehyClOvDni.jpg",
       "id": 399579,
       "adult": false,
       "backdrop_path": "/8yjqnpOfuFQg3qLRl9Ca1NgIBB5.jpg",
       "original_language": "en",
       "original_title": "Alita: Battle Angel",
       "genre_ids": [
         28,
         12,
         878,
         53
       ],
       "title": "Alita: Battle Angel",
       "vote_average": 6.9,
       "overview": "When Alita awakens with no memory of who she is in a future world she does not recognize, she is taken in by Ido, a compassionate doctor who realizes that somewhere in this abandoned cyborg shell is the heart and soul of a young woman with an extraordinary past.",
       "release_date": "2019-02-14"
     },
     {
       "popularity": 46.529,
       "vote_count": 296,
       "video": false,
       "poster_path": "/2YMTXZP7wExlJS5dBdTWoHO5wm3.jpg",
       "id": 291984,
       "adult": false,
       "backdrop_path": "/duXbSimVAH4ZThehr8EFq8d4zlU.jpg",
       "original_language": "en",
       "original_title": "The Death & Life of John F. Donovan",
       "genre_ids": [
         18
       ],
       "title": "The Death & Life of John F. Donovan",
       "vote_average": 7.5,
       "overview": "A movie star finds his correspondence with an 11-year-old actor exposed, prompting assumptions that begin to destroy his life and career.",
       "release_date": "2019-03-13"
     },
     {
       "popularity": 29.799,
       "vote_count": 8545,
       "video": false,
       "poster_path": "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg",
       "id": 244786,
       "adult": false,
       "backdrop_path": "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg",
       "original_language": "en",
       "original_title": "Whiplash",
       "genre_ids": [
         18,
         10402
       ],
       "title": "Whiplash",
       "vote_average": 8.4,
       "overview": "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.",
       "release_date": "2014-10-10"
     },
     {
       "popularity": 36.084,
       "vote_count": 9195,
       "video": false,
       "poster_path": "/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg",
       "id": 181808,
       "adult": false,
       "backdrop_path": "/5Iw7zQTHVRBOYpA0V6z0yypOPZh.jpg",
       "original_language": "en",
       "original_title": "Star Wars: The Last Jedi",
       "genre_ids": [
         28,
         12,
         14,
         878
       ],
       "title": "Star Wars: The Last Jedi",
       "vote_average": 7,
       "overview": "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order.",
       "release_date": "2017-12-15"
     },
     {
       "popularity": 23.073,
       "vote_count": 4162,
       "video": false,
       "poster_path": "/iBGRbLvg6kVc7wbS8wDdVHq6otm.jpg",
       "id": 334543,
       "adult": false,
       "backdrop_path": "/fgffluhvdOv79SkYaKrfRA0xkf4.jpg",
       "original_language": "en",
       "original_title": "Lion",
       "genre_ids": [
         18
       ],
       "title": "Lion",
       "vote_average": 8.2,
       "overview": "A five-year-old Indian boy gets lost on the streets of Calcutta, thousands of kilometers from home. He survives many challenges before being adopted by a couple in Australia; 25 years later, he sets out to find his lost family.",
       "release_date": "2016-11-25"
     },
     {
       "popularity": 38.22,
       "vote_count": 3,
       "video": false,
       "poster_path": "/aB1rCWGMsM2mm1kBDleaPkqUCFo.jpg",
       "id": 508664,
       "adult": false,
       "backdrop_path": "/zA6uqJdLMfqg0srHccAK8aLTHJE.jpg",
       "original_language": "en",
       "original_title": "Danger Close: The Battle of Long Tan",
       "genre_ids": [
         28,
         18,
         36,
         10752
       ],
       "title": "Danger Close: The Battle of Long Tan",
       "vote_average": 7.3,
       "overview": "For three and a half hours, in the pouring rain, amid the mud and shattered trees of a rubber plantation called Long Tan, Major Harry Smith and his dispersed company of 108 young and mostly inexperienced Australian and New Zealand soldiers are fighting for their lives, holding off an overwhelming enemy force of 2,500 battle hardened Viet Cong and North Vietnamese soldiers. With their ammunition running out, their casualties mounting and the enemy massing for a final assault, each man begins to search for the strength to triumph over an uncertain future with honour, decency and courage.",
       "release_date": "2019-08-08"
     },
     {
       "popularity": 29.223,
       "vote_count": 13069,
       "video": false,
       "poster_path": "/fnbjcRDYn6YviCcePDnGdyAkYsB.jpg",
       "id": 263115,
       "adult": false,
       "backdrop_path": "/yEv8c6i79vk06sZDC3Z9D8HQLVV.jpg",
       "original_language": "en",
       "original_title": "Logan",
       "genre_ids": [
         28,
         18,
         878
       ],
       "title": "Logan",
       "vote_average": 7.8,
       "overview": "In the near future, a weary Logan cares for an ailing Professor X in a hideout on the Mexican border. But Logan's attempts to hide from the world and his legacy are upended when a young mutant arrives, pursued by dark forces.",
       "release_date": "2017-03-03"
     }
   ]
 }
 
 */
