//
//  SingleBestCoffeeViewController.swift
//  AjmoApp
//
//  Created by Dora Franjic on 26/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import Kingfisher

class SingleBestCoffeeViewController: UIViewController {

    //@IBOutlet weak var expand: UIScrollView!
    @IBOutlet weak var flameFill: UIButton!
    private let popUpWindowView = PopUpView()
   
  
    @IBAction func showPopUp(_ sender: Any) {
        loadCustomViewIntoController()
    }
  
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var navItem: UINavigationBar!
    @IBOutlet weak var phoneIcon: UIButton!
    @IBOutlet weak var bat: UILabel!
    
    @IBOutlet weak var animatedImageView: UIImageView!
    
    @IBOutlet weak var idealLabel: UILabel!
    @IBOutlet weak var smokingImageView: UIImageView!
    @IBOutlet weak var smokingAreaLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var addressLocationLabel: UILabel!
    @IBOutlet weak var kmLocationLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var openClosed: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    var viewStruct: BestCoffeeStruct!
    
    convenience init(viewStruct:BestCoffeeStruct) {
        self.init()
        self.viewStruct = viewStruct
    }
   private func loadCustomViewIntoController() {
    let y = view.frame.height/3
    let customView:PopUpView = Bundle.main.loadNibNamed("PopUpView", owner: self, options: nil)?.first as! PopUpView
    customView.setUpView(viewStruct: self.viewStruct, y:y,open:self.openClosed.text ?? "")
        customView.isHidden = false
        customView.layer.cornerRadius = 10
    
       
   

    customView.okButton.addTarget(self, action: #selector(self.didPressButtonFromCustomView), for:.touchUpInside)
    view.addSubview(customView)
      }
    @objc func didPressButtonFromCustomView(sender:UIButton) {
        sender.superview?.isHidden = true
    }
    
 
    
    
    func decodeString(encodedString:String) -> NSAttributedString?
    {
        let encodedData = encodedString.data(using: String.Encoding.utf8)!
        do {
            return try NSAttributedString(data: encodedData,
            options: [
                      .documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue
                     ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func openOrClosed(workingHours:[[String:Any]]) -> String {

        let calendar = Calendar.current
        let date = Date()
        let dayOfWeek = calendar.component(.weekday, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let current = String(hour) + ":" + String(minute)
        if let start = workingHours[dayOfWeek]["start"] as? String {
            if let end = workingHours[dayOfWeek]["end"] as? String {
                if String(end.prefix(0)) != "0" {
                    if end > start {
                    if current > start && current < end {
                        return "Open"
                    } else {
                        return "Closed"
                        } } else {
                        if (current > start && current < "23:00") || (current > "00:00" && current < end) {
                            return "Open"
                        } else {
                            return "Closed"

                        }
                }
                } else {
                    if current > start && current < end {
                        return "Open"
                    } else {
                        return "Closed"
                    }
                }
            } }
        return ""
    }
     
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpScroll()
        //self.expand.isScrollEnabled = true
        self.bat.layer.cornerRadius = 10
        self.bat.layer.masksToBounds = true
        self.titleNameLabel.text = viewStruct.name
        self.addressLocationLabel.text = viewStruct.address
        self.kmLocationLabel.text = viewStruct.distanceKm
        self.typeLabel.text = viewStruct.typeSubtitle
        if viewStruct.bat {
            self.bat.isHidden = false
            self.flameFill.isHidden = false
        }
        if viewStruct.telephone != "" {
            self.telephoneLabel.isHidden = false
            self.phoneIcon.isHidden = false
            self.telephoneLabel.text = viewStruct.telephone
        }
         let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: self.topImageView.frame.size.width * UIScreen.main.scale, height: self.topImageView.frame.size.height * UIScreen.main.scale))
        self.topImageView.kf.setImage(with: URL(string:viewStruct.pictureURL), options:  [.backgroundDecode,.processor(resizingProcessor), .scaleFactor(UIScreen.main.scale),.cacheOriginalImage])
        
        self.idealLabel.text = decodeString(encodedString: viewStruct.descriptionOfProperty)?.string
        self.idealLabel.numberOfLines = 0
        
        if viewStruct.smokingAllowed {
            self.smokingAreaLabel.text = "Smoking area"
            self.smokingImageView.image = UIImage(named: "yes")
        } else {
            self.smokingAreaLabel.text = "No smoking area"
            self.smokingImageView.image = UIImage(named: "no")
        }
        self.openClosed.text = openOrClosed(workingHours: viewStruct.workingHours)
        if openClosed.text != "Open" {
            self.openClosed.textColor = .red
        }
        var imagesListArray = [UIImage]()
        for i in self.viewStruct.galleryImage {
                          if let photo = i["picture"] as? String {
                              let url = URL(string: photo)
                              DispatchQueue.global().async {
                                  let data = try? Data(contentsOf: url!)
                                  DispatchQueue.main.async {
                                      imagesListArray.append(UIImage(data: data!)!)
                                      self.animatedImageView.animationImages = imagesListArray
                                      self.animatedImageView.contentMode = .scaleAspectFill
                                      self.animatedImageView.clipsToBounds = true
                                      self.animatedImageView.animationDuration = 6.0
                                      self.animatedImageView.startAnimating()
                                  }
                              }
                          }
                      }
        
       
        
       
      
        
        

        // Do any additional setup after loading the view.
    }
    /*func setUpScroll() {
        let scroll:ScrollablePartView = Bundle.main.loadNibNamed("ScrollablePartView", owner: self, options: nil)?.first as! ScrollablePartView
        scroll.setup(withBestCoffee: self.viewStruct)
        self.expand.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
        expand.indicatorStyle = .default
        expand.contentSize = CGSize(width: view.frame.width * CGFloat(1), height: view.frame.height)
        expand.contentSize = CGSize(width:0,height:expand.contentSize.height)
        expand.isPagingEnabled = true
        scroll.frame = CGRect(x: view.frame.width * CGFloat(1), y: 100, width: view.frame.width, height: view.frame.height)
        expand.addSubview(scroll)
        view.addSubview(expand)
    }*/
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    
