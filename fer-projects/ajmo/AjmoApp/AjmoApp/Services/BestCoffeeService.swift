//
//  BestCoffeeService.swift
//  AjmoApp
//
//  Created by Dora Franjic on 20/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation

class BestCoffeeService {
    let baseUrl = "https://api.ajmo.hr/v3/venue/dashboard"
    
    func fetchBestCoffee(completion: @escaping (([BestCoffee]?) -> Void)) -> Void {
        if let url = URL(string: baseUrl) {
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let resultsList = json as? [String: Any], let results = resultsList["data"] as? [String: Any], let finalResults = results["customPicks"] as? [[String:Any]] {
                            var listOfBestCoffees = [BestCoffee]()
                          
                            for finals in finalResults { do {
                                if let title = finals["title"] as? String {
                                    if title == "Best coffee" {
                                        if let items = finals["items"] as? [[String:Any]] {
                                            for json in items {
                                        let bestCoffee = BestCoffee.createFrom(json: json)
                                        if let bestCoffee = bestCoffee {
                                            listOfBestCoffees.append(bestCoffee)
                                                } } } }
                                    }
                                }
                            }
                          
                            completion(listOfBestCoffees)
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
        
    
