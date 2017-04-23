//
//  LoggedInViewController.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/5/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseAuth

class LoggedInViewController: UIViewController {
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = Model.instance
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 12, longitude: 14, zoom: 6)
        
        self.googleMapView.camera = camera
        
        let markers = model.getReportList()
        for m in markers {
        
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(m.getLocation().getLatitude(), m.getLocation().getLongitude())
            marker.map = googleMapView
        }
        
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        let firebaseAuth = FIRAuth.auth()
        let model = Model.instance
        do {
            model.clearData()
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }

}
