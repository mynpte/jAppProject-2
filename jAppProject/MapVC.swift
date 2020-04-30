//
//  MapVC.swift
//  jAppProject
//
//  Created by FRANK on 24/4/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

   
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate let locationManager:CLLocationManager = CLLocationManager()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
    }

}




