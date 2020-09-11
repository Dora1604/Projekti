//
//  MyCell.swift
//  TopPop
//
//  Created by Dora Franjic on 21/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import DropDown

class MyCell: DropDownCell {

   @IBOutlet var myImageView: UIImageView!
  
       override func awakeFromNib() {
           super.awakeFromNib()
           myImageView.contentMode = .scaleAspectFit
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

       }
       
   }
    

