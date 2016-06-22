//
//  InterfaceController.swift
//  CarFinderWatch Extension
//
//  Created by nvovap on 6/22/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation
import WatchConnectivity



class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var LocationTable: WKInterfaceTable!
    
    var locations = [CLLocation]()
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: NSError?) {
        
    }
    
    
   
    
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        
        LocationTable.setNumberOfRows(locations.count, withRowType: "LocationRowController")
        
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        
    
    }
    
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        if let locationsArray = applicationContext["Locations"] as? [CLLocation] {
            locations = locationsArray
        }
    }
    
    func configureRows() {
        LocationTable.setNumberOfRows(locations.count, withRowType: "LocationRowController")
        
        for index in 0..<LocationTable.numberOfRows {
            if let row = LocationTable.rowController(at: index) as? LocationRowController {
                let location = locations[index]
                
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                let formattedString = String(format: "%0.3f, o.3f", latitude, longitude)
                    
                 row.CoordinatesLabel.setText(formattedString)
                
                let timeStamp = location.timestamp
                let dateForrmatter = DateFormatter()
                
                dateForrmatter.dateStyle = DateFormatter.Style.shortStyle
                dateForrmatter.timeStyle = DateFormatter.Style.shortStyle
                row.TimeLabel.setText(dateForrmatter.string(from: timeStamp))
            
            }
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        configureRows()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
