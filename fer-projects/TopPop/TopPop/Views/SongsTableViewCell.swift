//
//  SongsTableViewCell.swift
//  TopPop
//
//  Created by Dora Franjic on 20/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import UIKit

class SongsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var duration: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        number.textColor = UIColor(red:240/255, green: 248/255, blue: 255/255, alpha: 0.7)
        number.font = UIFont.systemFont(ofSize: 13)
        number.numberOfLines = 0
       
        title.textColor = UIColor(red:176/255, green: 196/255, blue: 222/255, alpha: 0.7)
        title.font = UIFont.boldSystemFont(ofSize: 13)
        title.numberOfLines = 0
        
        author.textColor = UIColor(red:221/255, green: 229/255, blue: 237/255, alpha: 0.8)
        author.font = UIFont.systemFont(ofSize: 13)
        author.numberOfLines = 0
      
        duration.textColor = UIColor(red:240/255, green: 248/255, blue: 255/255, alpha: 0.7)
        duration.font = UIFont.systemFont(ofSize: 13)
        duration.numberOfLines = 0
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        number.text = ""
        author.text = ""
        title.text = ""
        duration.text = ""
    }
    
    func setup(withSong song: SongCellModel) {
        self.number.text = String(song.number)
        author.text = song.author
        title.text = song.title
        duration.text = setUpDuration(duration: song.duration)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
             super.setSelected(selected, animated: animated)

         }
       
    
}


 
    

