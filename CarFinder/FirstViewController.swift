//
//  FirstViewController.swift
//  CarFinder
//
//  Created by nvovap on 6/15/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UITableViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        switch (CLLocationManager.authorizationStatus()) {
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied:
            let alert = UIAlertController(title: "Permission error", message: "This app needs location permission to work accurately.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        case .notDetermined:
            fallthrough
        default:
            locationManager.requestWhenInUseAuthorization()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addLocation(_ sender: AnyObject) {
        
    }
   

}

