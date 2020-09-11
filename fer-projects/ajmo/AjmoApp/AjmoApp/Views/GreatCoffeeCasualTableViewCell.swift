//
//  GreatCoffeeCasualTableViewCell.swift
//  AjmoApp
//
//  Created by Dora Franjic on 26/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import Kingfisher

class GreatCoffeeCasualTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var kmDistance: UILabel!
    @IBOutlet weak var propertyPicture: UIImageView!
    override func awakeFromNib() {
          super.awakeFromNib()
      }

      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
      }
      
      func setup(withCasual casual: CasualCellModel) {
          titleLabel.text = casual.title
          addressLabel.text = casual.address
          let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.propertyPicture.frame.size.width * UIScreen.main.scale, height: self.propertyPicture.frame.size.height * UIScreen.main.scale))
        self.propertyPicture.kf.setImage(with: URL(string:casual.imageUrl!), options:  [.backgroundDecode,.processor(resizingProcessor), .scaleFactor(UIScreen.main.scale),.cacheOriginalImage])
      }
    
}
