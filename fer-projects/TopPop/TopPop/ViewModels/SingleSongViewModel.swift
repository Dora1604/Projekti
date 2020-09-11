//
//  SingleSongViewModel.swift
//  TopPop
//
//  Created by Dora Franjic on 19/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
class SingleSongViewModel {
    var song: Song? = nil
        
   
    init(song: Song) {
        self.song = song
    }
    
    var number: Int {
        return song?.number ?? 0
    }

    var songTitle: String {
        return song?.title ?? ""
    }
    
    var author: String {
        if let name = song?.author["name"] as? String {
            return name
        }
        return ""
    }
    var duration: Int {
        return song?.duration ?? 0
    }
    var albumTitle: String {
           if let albumTitle = song?.album["title"] as? String {
               return albumTitle
           }
           return ""
       }
    
    var albumCoverURL: URL? {
        if let albumCoverURL = song?.album["cover"] as? String{
            return URL(string: albumCoverURL)
        }
        return nil
    }
    
    var albumName: String? {
        if let albumName = song?.album["title"] as? String {
                   return albumName
               }
        return nil
        
    }
    var albumId: Int? {
        if let albumId = song?.album["id"] as? Int {
                   return albumId
               }
        return nil
        
    }
    
}
