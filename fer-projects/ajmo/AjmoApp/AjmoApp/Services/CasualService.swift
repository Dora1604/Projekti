//
//  CasualService.swift
//  AjmoApp
//
//  Created by Dora Franjic on 27/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

//
//  CasualService.swift
//  AjmoApp
//
//  Created by Danica Vladić on 27/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation

class CasualService {
    let baseUrl = "https://api.ajmo.hr/v3/venue/dashboard"
    var listOfCasualsTemp = [Casual]()
    var listOfCasuals = [Casual]()
    var flag = 0
    var secondFlag = 0
    func fetchCasualPlaces(filter: String,completion: @escaping (([Casual]?) -> Void)) -> Void {
        if let url = URL(string: baseUrl) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let resultsList = json as? [String: Any], let results = resultsList["data"] as? [String: Any], let finalResults = results["customPicks"] as? [[String:Any]], let trending = results["trending"] as? [[String: Any]] {
                            //print(finalResults)
                            for finals in finalResults { do {
                                if let title = finals["title"] as? String {
                                    if title == "Best coffee" || title == "Live gigs" {
                                        if let items = finals["items"] as? [[String:Any]] {
                                           let casuals = items.map({ json -> Casual? in
                                               //print(json)
                                               if
                                                let allTags = json["allTags"] as? [String: Any],
                                                   let title = json["name"] as? String,
                                                   let image = json["picture_url"] as? String,
                                                   let address = json["address"] as? String {
                                                for (_, value) in allTags {
                                                    //print(tag)
                                                    if let arrayValue = value as? [[String:Any]]
                                                    {
                                                        for item in arrayValue {
                                                        if let name = item["name"] as? String {
                                                            if name == filter {
                                                                //print(name)
                                                            //self.flag = 1
                                                            //if self.flag == 1 {
                                                            let casual = Casual(title: title, address: address, imageUrl: image)
                                                                //self.flag = 0
                                                            return casual
                                                            //}
                                                                
                                                            }
                                                        } else {
                                                            return nil
                                                            } }}
                                                    
                                                     }
                                               } else {
                                                   return nil
                                                }
                                            return nil
                                           }).filter { $0 != nil } .map { $0! }
                                            for c in casuals {
                                                    //print(c.title)
                                                    self.listOfCasuals.append(c)
                                            }
                                        } }
                                }
                                }
                               let casuals = trending.map({ json -> Casual? in
                                    //print(json)
                                    if
                                         let allTags = json["allTags"] as? [String: Any],
                                            let title = json["name"] as? String,
                                        let image = json["picture_url"] as? String,
                                            let address = json["address"] as? String {
                                        for (_, value) in allTags {
                                             if let arrayValue = value as? [[String:Any]]
                                             {
                                                 for item in arrayValue {
                                                 if let name = item["name"] as? String {
                                                     if name == "casual" {
                                                         //print(name)
                                                     //self.secondFlag = 1
                                                     //if self.secondFlag == 1 {
                                                     let casual = Casual(title: title, address: address, imageUrl: image)
                                                         //self.secondFlag = 0
                                                     return casual
                                                     //}
                                                         
                                                     }
                                                 }  }
                                                
                                             } else { return nil }
                                             
                                              }
                                        } else {
                                            return nil
                                         }
                                     return nil
                                    }).filter { $0 != nil } .map { $0! }
                                
                                for c in casuals {
                                        //print(c)
                                        self.listOfCasuals.append(c)
                                }
                            }
                            
                            for c in self.listOfCasuals {
                                if !self.listOfCasualsTemp.contains(c) {
                                    self.listOfCasualsTemp.append(c)
                                }
                            }
                            //print(self.listOfCasualsTemp.count)
                            completion(self.listOfCasualsTemp)
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
