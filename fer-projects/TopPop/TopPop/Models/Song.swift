//
//  Song.swift
//  TopPop
//
//  Created by Dora Franjic on 19/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
class Song: NSObject {
    
    var number: Int
    var title: String
    var author: [String:Any]
    var duration: Int
    var name: String
    var album: [String:Any]
    
    
    init(number: Int, title: String, author: [String:Any], duration:Int, album: [String:Any]) {
        self.number = number
        self.title = title
        self.author = author
        self.duration = duration
        self.name = ""
        self.album = album
        
    }
    
    init(number: Int, title: String, name: String, duration:Int, album:[String:Any]) {
        self.number = number
        self.title = title
        self.name = name
        self.duration = duration
        self.author = ["":""]
        self.album = album
       
        
    }
    
}
