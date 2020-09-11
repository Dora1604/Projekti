//
//  Slide.swift
//  AjmoApp
//
//  Created by Dora Franjic on 25/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class Slide: UIView {
    
    @IBOutlet weak var batFlameButton: UIButton!
    @IBOutlet weak var batLabel: UILabel!
    @IBOutlet weak var typeSubtitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var whiteScreen: UITextView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var name: UILabel!
    var helpStruct: BestCoffeeStruct? = nil

  
    func setup(withBestCoffee bestCoffee:BestCoffeeStruct) {
        self.helpStruct = bestCoffee
        self.name.text = bestCoffee.name
        self.typeSubtitle.text = bestCoffee.typeSubtitle
        let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.imageView.frame.size.width * UIScreen.main.scale, height: self.imageView.frame.size.height * UIScreen.main.scale))
        self.imageView.kf.setImage(with: URL(string:bestCoffee.pictureURL), options:  [.backgroundDecode,.processor(resizingProcessor), .scaleFactor(UIScreen.main.scale),.cacheOriginalImage])
        if bestCoffee.bat {
            self.batFlameButton.isHidden = false
            self.batLabel.isHidden = false
            self.batLabel.layer.cornerRadius = 10
            self.batLabel.layer.masksToBounds = true
        }
       
        
        }
    
   
  

     }
