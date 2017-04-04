//
//  Location.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/27/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation

class Location {
    
    var _longitude: Double
    var _latitude: Double
    
    init(lat: Double, longit: Double) {
        _latitude = lat
        _longitude = longit
    }
    
    func getLongitude() -> Double {
        return _longitude
    }
    
    func getLatitude() -> Double {
        return _latitude
    }
    
    func toString() -> String {
        return "\(_latitude), \(_longitude)"
    }
    
    func isEqual(object: AnyObject?) -> Bool {
        let object = object as? Location
        if (object?.getLongitude() == _longitude && object?.getLatitude() == _latitude) {
            return true
        } else {
            return false
        }
    }
    
}
