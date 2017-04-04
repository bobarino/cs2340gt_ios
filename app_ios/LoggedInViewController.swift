//
//  LoggedInViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/5/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import UIKit
import GoogleMaps

class LoggedInViewController: UIViewController {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6)
        
        self.googleMapView.camera = camera
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = googleMapView
        
    }

}
