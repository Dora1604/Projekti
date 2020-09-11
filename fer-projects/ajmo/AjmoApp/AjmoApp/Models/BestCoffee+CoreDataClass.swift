//
//  BestCoffee+CoreDataClass.swift
//  AjmoApp
//
//  Created by Dora Franjic on 24/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
import CoreData

@objc(BestCoffee)
public class BestCoffee: NSManagedObject {
    class func getEntityName() -> String {
        return "BestCoffee"
    }
    
    
    class func firstOrCreate(withTitle name: String) -> BestCoffee? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<BestCoffee> = BestCoffee.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        request.returnsObjectsAsFaults = false

        do {
            let bestCoffees = try context.fetch(request)
            if let bestCoffee = bestCoffees.first {
                return bestCoffee
            } else {
                let newBestCoffee = BestCoffee(context: context)
                
                return newBestCoffee
            }
        } catch {
            return nil
        }
    }
   
    
    class func createFrom(json: [String: Any]) -> BestCoffee? {
        if
            let id = json["id"] as? Int32,
            let subtitle = json["subtitle"] as? String,
            let pictureUrl = json["picture_url"] as? String,
            let venueCategories = json["venue_categories"] as? [[String: Any]],
            let primaryTagGroup = json["primary_tag_group"] as? String,
            let allTags = json["allTags"] as? [String:Any],
            let address = json["address"] as? String,
            let opened = json["opened"] as? Bool,
            let web = json["web"] as? String,
            let telephone = json["telephone"] as? String,
            let shareLink = json["share_link"] as? String,
            let city = json["city"] as? String,
            let latitude = json["lat"] as? Double,
            let longitude = json["lon"] as? Double,
            let trending = json["trending"] as? Bool,
            let bat = json["bat"] as? Bool,
            let hasQRCode = json["has_qr_code"] as? Bool,
            let active = json["active"] as? Bool,
            let smokingArea = json["smoking_area"] as? Bool,
            let workingHours = json["working_hours"] as? [[String:Any]],
            let gallery = json["gallery"] as? [[String:Any]],
            let type = json["type"] as? String,
            let name = json["name"] as? String,
            let desc = json["description"] as? String
            
            
        
        {
            
            if let bestCoffee = BestCoffee.firstOrCreate(withTitle: name) {
                bestCoffee.id = id
                bestCoffee.subtitle = subtitle
                bestCoffee.pictureUrl = pictureUrl
                bestCoffee.venueCategories = venueCategories
                bestCoffee.primaryTagGroup = primaryTagGroup
                bestCoffee.allTags = allTags
                bestCoffee.address = address
                bestCoffee.opened = opened
                bestCoffee.web = web
                bestCoffee.telephone = telephone
                bestCoffee.shareLink = shareLink
                bestCoffee.city = city
                bestCoffee.lattitude = latitude
                bestCoffee.longitude = longitude
                bestCoffee.trending = trending
                bestCoffee.bat = bat
                bestCoffee.hasQRCode = hasQRCode
                bestCoffee.active = active
                bestCoffee.smokingArea = smokingArea
                bestCoffee.workingHours = workingHours
                bestCoffee.gallery = gallery
                bestCoffee.type = type
                bestCoffee.name = name
                bestCoffee.descriptionOfProperty = desc
                
                
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return bestCoffee
                } catch {
                    print("Failed saving")
                }
        }
       
    }
     
       return nil
}
    

}
