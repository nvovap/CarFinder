//
//  DataManager.swift
//  CarFinder
//
//  Created by nvovap on 6/16/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import Foundation
import CoreLocation

class DataManager {
    static let sharedInstance = DataManager()
    var locations: [CLLocation]
    
    private init() {
        locations = [CLLocation]()
    }
}



