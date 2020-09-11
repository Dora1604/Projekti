//
//  SingleSongViewController.swift
//  TopPop
//
//  Created by Dora Franjic on 19/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import Kingfisher


class SingleSongViewController: UIViewController {

    
    @IBOutlet weak var titleOfSong: UILabel!
    
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumSongs: UILabel!
    var viewModel: SingleSongViewModel!
    
    convenience init(viewModel: SingleSongViewModel) {
        self.init()
        self.viewModel = viewModel
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func setUpDuration(duration: Int) -> String {
        let minutes = duration/60
        let seconds = duration%60
        if minutes < 10 {
            if seconds < 10 {
                return "0"+String(minutes)+":"+"0"+String(seconds)
            } else {
                return "0"+String(minutes)+":"+String(seconds)
            }
            
        }
        return String(minutes)+":"+String(seconds)
        
    }
    
    func bindViewModel() {
        titleOfSong.text =  viewModel.songTitle
        titleOfSong.numberOfLines = 0
        let processor = RoundCornerImageProcessor(cornerRadius: 50)
        self.albumImage.kf.setImage(with: self.viewModel.albumCoverURL, options: [.processor(processor), .cacheSerializer(FormatIndicatedCacheSerializer.png)]) // rounded image sometimes not transparent
        albumName.text = self.viewModel.albumName
        albumName.numberOfLines = 0
        AlbumService().fetchAlbum(id: viewModel.albumId ?? 0) { [weak self] (albums) in
            DispatchQueue.main.async {
            
            if let album = albums?[0] {
                self?.albumSongs.text = album.songNames
                self?.albumSongs.numberOfLines = 0
                }
                
            }
            } }
        
       
    }

