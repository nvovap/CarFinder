//
//  SecondViewController.swift
//  CarFinder
//
//  Created by nvovap on 6/15/16.
//  Copyright © 2016 nvovap. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        let locations = DataManager.sharedInstance.locations
        var annotations = [MKPointAnnotation]()
        
        
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotations.append(annotation)
        }
        
        let oldAnnotations = mapView.annotations
        mapView.removeAnnotations(oldAnnotations)
        
        mapView.addAnnotations(annotations)
        
        if annotations.count > 0 {
            let region = MKCoordinateRegionMake(annotations[0].coordinate, MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.regionThatFits(region)
        }
        
        mapView.showsUserLocation = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

