//
//  MapViewController.swift
//  jAppProject
//
//  Created by Mild on 13/4/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class MapViewController: UIViewController {
    
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeter: Double = 10000 //set ค่าการซูม
    
    override func viewDidLoad() {
        super.viewDidLoad()
                checkLocationServices()
        
                //จากtableviewเชื่อมให้มาอยู่บนหน้าmap
                let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! locationSearchTable
                resultSearchController = UISearchController(searchResultsController: locationSearchTable)
                resultSearchController?.searchResultsUpdater = locationSearchTable
                
                //ช่องเสริช
            var searchBar = resultSearchController!.searchBar
                searchBar.sizeToFit()
                searchBar.placeholder = "Search for places"
                
        
                navigationItem.titleView = resultSearchController?.searchBar
        
                resultSearchController?.hidesNavigationBarDuringPresentation = false
                resultSearchController?.dimsBackgroundDuringPresentation = true
                definesPresentationContext = true
                locationSearchTable.mapView = mapView
                
        
                //เรียกใช้ปักมุด
                locationSearchTable.handleMapSearchDelegate = self
                //navigation button
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancle))
    }
    var local = ""
    
    @objc func handleDone(){
        print("Done")
    
        let storyBord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvc = self.storyboard?.instantiateViewController(identifier: "createVC") as! createVC
        mvc.local = local
//        self.local = "\(String(describing: selectedPin!))"
        print("local :",local)
        self.view.window?.rootViewController = mvc
        
    }
//    @IBAction func btnsubmit(_ sender: Any) {
//
//        let storyBord: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let mvc = self.storyboard?.instantiateViewController(identifier: "createVC") as! createVC
//        mvc.local = local
//        self.view.window?.rootViewController = mvc
//    }
    
   
    
    @objc func handleCancle(){
        self.dismiss(animated: true, completion: nil)
    }
    func setupLocationManeger(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //zoom user location
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
            mapView.setRegion(region, animated: true)
        }
    }
     func checkLocationServices(){
            if CLLocationManager.locationServicesEnabled(){
                setupLocationManeger()
                checkLocationAuthorization()
            }else{
                //show alert
            }
        }
        //alert permission
        func checkLocationAuthorization(){
            switch CLLocationManager.authorizationStatus() {
                //first time that app get the user location
            case .authorizedWhenInUse:
    //            // do a map stuff
                //mapView.showsUserLocation = true
                centerViewOnUserLocation()
                break
    //            when u poped up the thing n hit not allow siad dont give that permission
            case .denied:
                // show alert instructing them how to turn on permission
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                //show the alert letting them know what's up (the user cannot change this app status)
                break
            case .authorizedAlways:
                break
            }
        }
    
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
//            annotation.subtitle = "\(city) \(state)"
            print("แสดง state :", state)
            print("แสดง city :", city)
        }
        print("แสดง-selectedPin :",selectedPin!.name)
        print("แสดง-selectedPin-2 :",selectedPin!)
        self.local = "\(selectedPin!.name!)"
        
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
        print("แสดง span :",span)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        print("แสดง region :",region)  //ละจิจูด และ ลองจิจูด
        mapView.setRegion(region, animated: true)
    }
}
