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
        segControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        
        view.addSubview(segControl)
        
        //let topConst = segControl.topAnchor.constraintEqualToAnchor(view.topAnchor)
        //let leadConst = segControl.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
        //let trailConst = segControl.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        
        let topConst = segControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadConst = segControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailConst = segControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConst.active = true
        leadConst.active = true
        trailConst.active = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("MapViewController did load")
    }
    
    func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
            case 0 : mapView.mapType = .Standard
            case 1 : mapView.mapType = .Hybrid
            case 2 : mapView.mapType = .Satellite
            default: break
        }
    }
    

    
}


