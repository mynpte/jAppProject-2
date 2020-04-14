//
//  map.swift
//  jAppProject
//
//  Created by Mild on 7/4/2563 BE.
//  Copyright © 2563 mindfrank. All rights reserved.
//

//import Foundation
import MapKit

class myAnnotation: NSObject, MKAnnotation  {
    
    let title: String?
    let locationName: String
    let discipline : String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle : String? {
        return locationName
    }
    
}

