//
//  AlbumService.swift
//  TopPop
//
//  Created by Dora Franjic on 22/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
class AlbumService {
    
    func fetchAlbum(id: Int, completion: @escaping (([Album]?) -> Void)) -> Void {
        let baseUrl = "https://api.deezer.com/album/\(id)"
        if let url = URL(string: baseUrl) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let resultsList = json as? [String: Any], let results = resultsList["tracks"] as? [String: Any], let finalResults = results["data"] as? [[String:Any]] {
                            let albums = finalResults.map({ json -> Album? in
                                if
                                    let id = resultsList["id"] as? Int
                                    {
                                        let album = Album(id:id,songs:finalResults)
                                    return album
                                } else {
                                    return nil
                                }
                            }).filter { $0 != nil } .map { $0! }
                            completion(albums)
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
