//
//  FirstViewController.swift
//  CarFinder
//
//  Created by nvovap on 6/15/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit
import CoreLocation
import WatchConnectivity

class FirstViewController: UITableViewController, CLLocationManagerDelegate, WCSessionDelegate {
    
    
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: NSError?) {
        
    }
    
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
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
        
        
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
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
        var location : CLLocation
        
        if (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            location = CLLocation(latitude: 32.830579, longitude: -117.153839)
        } else {
            location = locationManager.location!
        }
        
        DataManager.sharedInstance.locations.insert(location, at: 0)
        
        tableView.reloadData()
        
        if (WCSession.isSupported()) {
            do {
                let userDict = ["Locations": DataManager.sharedInstance.locations]
                try WCSession.default().updateApplicationContext(userDict)
            } catch {
                print("Error transferring data")
            }
        }
        
    }
    
    
    //MARK: - Table delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.sharedInstance.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        cell.tag = indexPath.row
        
        let entry :CLLocation = DataManager.sharedInstance.locations[indexPath.row]
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mm:ss, MM-dd-yyyy"
        
        cell.textLabel?.text = "\(entry.coordinate.latitude), \(entry.coordinate.longitude)"
        cell.detailTextLabel?.text = dateFormatter.string(from: entry.timestamp)
        
        return cell
        
    }
   

}

