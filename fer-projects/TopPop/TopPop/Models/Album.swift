//
//  Album.swift
//  TopPop
//
//  Created by Dora Franjic on 22/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
class Album: NSObject {
    
    var id: Int
    var songs: [[String:Any]]
    var songNames: String = ""
    
    init(id: Int, songs: [[String:Any]]) {
        self.id = id
        for song in songs {
            if let name = song["title"] as? String {
                self.songNames.append(name)
                self.songNames.append("\n")
            }
        }
        
        self.songs = songs
    }
    
}
