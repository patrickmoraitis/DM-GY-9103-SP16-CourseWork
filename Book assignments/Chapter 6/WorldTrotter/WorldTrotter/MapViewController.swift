//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Patrick Moraitis on 4/19/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

//why u no import Foundation ?

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("MapViewController did load")
    }
    
}


