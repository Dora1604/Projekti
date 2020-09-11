//
//  BestCoffeeViewModel.swift
//  AjmoApp
//
//  Created by Dora Franjic on 25/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
import UIKit
import CoreData
struct BestCoffeeStruct {
    
    var name: String
    var typeSubtitle: String
    var lat: Double
    var lon: Double
    var pictureURL: String
    var bat: Bool
    var workingHours: [[String:Any]]
    var smokingAllowed: Bool
    var address: String
    var allTags: [String:Any]
    var descriptionOfProperty: String
    var telephone: String
    var distanceKm: String = ""
    var galleryImage: [[String:Any]]
    var tagGroup: String
    
    init(bestCoffee:BestCoffee) {
        self.name = bestCoffee.name ?? ""
        self.typeSubtitle = bestCoffee.subtitle ?? ""
        self.lat = bestCoffee.lattitude
        self.lon = bestCoffee.longitude
        self.pictureURL = bestCoffee.pictureUrl ?? ""
        self.bat = bestCoffee.bat
        self.workingHours = bestCoffee.workingHours ?? [["":""]]
        self.smokingAllowed = bestCoffee.smokingArea
        self.address = bestCoffee.address ?? ""
        self.allTags = bestCoffee.allTags ?? ["":""]
        self.descriptionOfProperty = bestCoffee.descriptionOfProperty ?? ""
        self.telephone = bestCoffee.telephone ?? ""
        self.galleryImage = bestCoffee.gallery ?? [["":""]]
        self.tagGroup = bestCoffee.primaryTagGroup ?? ""
    }
}

class BestCoffeeViewModel {
    var bestCoffee : [BestCoffee]?
    
    func fetchBestCoffee(completion: @escaping(() -> Void)) {
        BestCoffeeService().fetchBestCoffee { [weak self] (bestCoffees) in
            self?.bestCoffee = DataController.shared.fetchBestCoffee()
            completion()
        }
    }
    
}
