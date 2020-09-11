//
//  ViewController.swift
//  AjmoApp
//
//  Created by Dora Franjic on 20/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    
    @IBAction func listCasuals(_ sender: Any) {
        let casualViewModel = CasualViewModel()
        let greatCoffeeCasualViewController = GreatCoffeeCasualViewController(viewModel: casualViewModel, filter:"casual")
        navigationController?.pushViewController(greatCoffeeCasualViewController, animated: true)
    }
    
    @IBAction func listGreatCoffee(_ sender: Any) {
        let casualViewModel = CasualViewModel()
            let greatCoffeeCasualViewController = GreatCoffeeCasualViewController(viewModel: casualViewModel, filter:"great coffee")
            navigationController?.pushViewController(greatCoffeeCasualViewController, animated: true)
        }
    
    @IBOutlet weak var bestCoffee: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var casualButton: UIButton!
    @IBOutlet weak var greatCoffeeButton: UIButton!
    var slides:[Slide] = [];
    var viewModel: BestCoffeeViewModel!
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    convenience init(viewModel:BestCoffeeViewModel) {
        self.init()
        self.viewModel = viewModel
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locManager.requestAlwaysAuthorization()
        self.locManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
             self.locManager.distanceFilter = kCLDistanceFilterNone
            locManager.startUpdatingLocation()
           
        }
        bindViewModel()
        scrollView.isPagingEnabled = true
        self.casualButton.layer.cornerRadius = 10
        self.casualButton.clipsToBounds = true
        self.greatCoffeeButton.layer.cornerRadius = 10
        self.greatCoffeeButton.clipsToBounds = true
        self.bestCoffee.textColor = .white
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: animated)
       }
    func deg2rad(deg:Double) -> Double {
           return deg * .pi / 180
       }
       func rad2deg(rad:Double) -> Double {
           return rad * 180.0 / .pi
       }
       
       func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double) -> Double {
           let theta = lon1 - lon2
           var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
           dist = acos(dist)
           dist = rad2deg(rad: dist)
           dist = dist * 60 * 1.1515
           dist = dist * 1.609344
           return dist
       }
    func createSlides() -> [Slide] {
        var slides : [Slide] = []
        if let listOfBestCoffee = self.viewModel.bestCoffee {
            for bestCoffee in listOfBestCoffee {
                let slide:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
               //DODAJ HOTPICK
                if let locValue = locManager.location?.coordinate {
                    let latitude = locValue.latitude
                    let longitude = locValue.longitude
                    let km = distance(lat1: latitude, lon1: longitude, lat2: bestCoffee.lattitude, lon2: bestCoffee.longitude)
                    let kmRounded = Double(round(100*km)/100)
                    slide.distance.text = String(kmRounded) + " km"
                }
                slide.whiteScreen.layer.cornerRadius = 10
                slide.imageView.layer.cornerRadius = 10
                let slideToBe = BestCoffeeStruct(bestCoffee: bestCoffee)
                slide.setup(withBestCoffee: slideToBe)
                
                let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
                slide.addGestureRecognizer(gesture)
                slides.append(slide)
        }
            
        }
         
      
          return slides
      }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if let slide = sender.view as? Slide {
            if var helpStruct = slide.helpStruct {
            helpStruct.distanceKm = slide.distance.text ?? ""
            let singleBestCoffeeController = SingleBestCoffeeViewController(viewStruct:helpStruct)
            navigationController?.pushViewController(singleBestCoffeeController, animated: true)
            }  }       // Do what you want
    }
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: view.frame.height/3, width: view.frame.width, height: view.frame.height/2)
        scrollView.indicatorStyle = .default
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height/2)
        scrollView.contentSize = CGSize(width:scrollView.contentSize.width,height:0)
        scrollView.isPagingEnabled = true
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    func bindViewModel() {
        viewModel.fetchBestCoffee {
            DispatchQueue.main.async {
                self.slides = self.createSlides()
                self.setupSlideScrollView(slides: self.slides)
            }
            }
    }
   


}

