//
//  Casual.swift
//  AjmoApp
//
//  Created by Dora Franjic on 27/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation

class Casual: NSObject {
    @objc dynamic var title: String
    @objc dynamic var address: String
    //@objc dynamic var summary: String
    @objc dynamic var imageUrl: String?
    
    init(title: String, address: String, imageUrl: String) {
        self.title = title
        self.address = address
        self.imageUrl = imageUrl
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? Casual {
            return self.title == other.title
        } else {
            return false
        }
    }

    override var hash: Int {
        return title.hashValue
    }
}
