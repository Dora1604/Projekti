//
//  CasualViewModel.swift
//  AjmoApp
//
//  Created by Dora Franjic on 27/08/2020.
//  Copyright © 2020 Dora Franjic. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CasualCellModel {
    
    let title: String
    let address: String
    //let distance: Double
    let imageUrl: String?
    //let allTags: [[String: Any]]
    
    init(casual: Casual) {
        self.title = casual.title
        self.address = casual.address
        self.imageUrl = casual.imageUrl
    }
}

class CasualViewModel {
    
    var casuals: [Casual]?
    
    func fetchCasual(filter:String,completion: @escaping (() -> Void))  {
        CasualService().fetchCasualPlaces(filter:filter) { [weak self] (casuals) in
            self?.casuals = casuals
            completion()
        }
    }
   

    func casual(atIndex index: Int) -> CasualCellModel? {
        guard let casuals = casuals else {
            return nil
        }
        let casualCellModel = CasualCellModel(casual: casuals[index])
        return casualCellModel
    }

    func numberOfCasuals() -> Int {
        return casuals?.count ?? 0
    }
}

