//
//  SongsViewModel.swift
//  TopPop
//
//  Created by Dora Franjic on 19/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation


struct SongCellModel {
    
    let number: Int
    let title: String
    let author: String
    let duration: Int
    
    init(song: Song) {
        self.number = song.number
        self.title = song.title
        if let name = song.author["name"] as? String {
            self.author = name
            
        } else {
            self.author = ""
        }
        self.duration = song.duration
    }
}

class SongsViewModel {
    
    
    var songs: [Song]?
    
    func fetchSongs(completion: @escaping (() -> Void))  {
        SongService().fetchSongs { [weak self] (songs) in
            self?.songs = songs
            completion()
        }
      
    }
    
    func viewModel(atIndex index: Int) -> SingleSongViewModel? {
        if let songs = songs {
            if index >= 0 && index < songs.count {
                return SingleSongViewModel(song: songs[index])
            }
        }
        return nil
    }
    

    
    func song(atIndex index: Int) -> SongCellModel? {
        guard let songs = songs else {
            return nil
        }
        
        let songCellModel = SongCellModel(song: songs[index])
        return songCellModel
    }
    
    func numberOfSongs() -> Int {
        return songs?.count ?? 0
    }
    
    
    
}
