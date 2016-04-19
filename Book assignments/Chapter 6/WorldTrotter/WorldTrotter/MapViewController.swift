//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Patrick Moraitis on 4/19/16.
//  Copyright © 2016 Patrick Moraitis. All rights reserved.
//

//why u no import Foundayschunz ?

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
        let segControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segControl.selectedSegmentIndex = 0
        segControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segControl)
        
        let topConst = segControl.topAnchor.constraintEqualToAnchor(view.topAnchor)
        let leadConst = segControl.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
        let trailConst = segControl.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        
        topConst.active = true
        leadConst.active = true
        trailConst.active = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("MapViewController did load")
    }
    

    
}


