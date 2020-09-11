//
//  PopUpView.swift
//  AjmoApp
//
//  Created by Dora Franjic on 27/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit

class PopUpView: UIView {

    
    

     @IBOutlet weak var mon: UILabel!
   
    @IBOutlet weak var sunShown: UILabel!
    @IBOutlet weak var satShown: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var sun: UILabel!
    @IBOutlet weak var sat: UILabel!
    @IBOutlet weak var fri: UILabel!
    @IBOutlet weak var thu: UILabel!
    @IBOutlet weak var wed: UILabel!
    @IBOutlet weak var tue: UILabel!
    func setUpView(viewStruct:BestCoffeeStruct, y: CGFloat, open: String) {
        if open == "Closed" {
            self.open.textColor = .red
        }
        self.open.text = open
        let numberOfDays = viewStruct.workingHours.count
        if numberOfDays > 5 {
            sat.isHidden = false
            satShown.isHidden = false
            if numberOfDays == 7 {
                sun.isHidden = false
                sunShown.isHidden = false
            }
        }
        for i in 0...numberOfDays-1{
          if let start = viewStruct.workingHours[i]["start"] as? String {
              if let end =  viewStruct.workingHours[i]["end"] as? String {
                    switch i {
                    case 0:
                        mon.text = start + "-" + end
                    case 1:
                        tue.text = start + "-" + end
                    case 2:
                        wed.text = start + "-" + end
                    case 3:
                        thu.text = start + "-" + end
                    case 4:
                        fri.text = start + "-" + end
                    case 5:
                        sat.text = start + "-" + end
                    case 6:
                        sun.text = start + "-" + end
                    default:
                        print("Error")
            }
        }
            }
        }
        self.frame = CGRect(x:40, y:y , width: 330, height: 350)
        
    }

}
