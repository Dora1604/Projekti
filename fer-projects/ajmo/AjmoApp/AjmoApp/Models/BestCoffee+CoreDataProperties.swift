//
//  BestCoffee+CoreDataProperties.swift
//  AjmoApp
//
//  Created by Dora Franjic on 24/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
import CoreData


extension BestCoffee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BestCoffee> {
        return NSFetchRequest<BestCoffee>(entityName: "BestCoffee")
    }

    @NSManaged public var active: Bool
    @NSManaged public var address: String?
    @NSManaged public var allTags: [String:Any]?
    @NSManaged public var bat: Bool
    @NSManaged public var city: String?
    @NSManaged public var descriptionOfProperty: String?
    @NSManaged public var gallery: [[String:Any]]?
    @NSManaged public var hasQRCode: Bool
    @NSManaged public var id: Int32
    @NSManaged public var lattitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var opened: Bool
    @NSManaged public var pictureUrl: String?
    @NSManaged public var primaryTagGroup: String?
    @NSManaged public var promoted: Bool
    @NSManaged public var shareLink: String?
    @NSManaged public var smokingArea: Bool
    @NSManaged public var subtitle: String?
    @NSManaged public var telephone: String?
    @NSManaged public var trending: Bool
    @NSManaged public var type: String?
    @NSManaged public var venueCategories: [[String:Any]]?
    @NSManaged public var web: String?
    @NSManaged public var workingHours: [[String:Any]]?

}
