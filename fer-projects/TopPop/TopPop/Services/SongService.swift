//
//  SongService.swift
//  TopPop
//
//  Created by Dora Franjic on 19/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation

class SongService {
    let baseUrl = "https://api.deezer.com/chart"
    
    func fetchSongs(completion: @escaping (([Song]?) -> Void)) -> Void {
        if let url = URL(string: baseUrl) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let resultsList = json as? [String: Any], let results = resultsList["tracks"] as? [String: Any], let finalResults = results["data"] as? [[String:Any]] {
                            let songs = finalResults.map({ json -> Song? in
                                if
                                    let number = json["position"] as? Int,
                                    let title = json["title"] as? String,
                                    let duration = json["duration"] as? Int,
                                    let author = json["artist"] as? [String: Any],
                                    let album = json["album"] as? [String: Any]
                                    
                                    {
                                        
                                        let song = Song(number: number, title: title, author: author, duration: duration, album:album)
                                    return song
                                } else {
                                    return nil
                                }
                            }).filter { $0 != nil } .map { $0! }
                            completion(songs)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
        
    }
}
