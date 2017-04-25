//
//  WaterPurityReport.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 4/17/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//


import Foundation

class WaterPurityReport: Equatable {
    
    static var Next_Id = 0
    
    var reporter: Account
    var date_time: String
    var id: Int
    var condition: String
    var waterCondition: [String] = ["Safe", "Treatable", "Unsafe"]
    var location: Location
    var viralPPM: Int
    var contaminantPPM: Int
    var email: String
    
    init(_id: Int, _reporter: Account, _condition: String, _viralPPM: Int, _contaminantPPM: Int, _dateTime: String, place: Location, emailAddress: String) {
        reporter = _reporter
        condition = WaterPurityReport.setCondition(newCondition: _condition)
        viralPPM = _viralPPM
        contaminantPPM = _contaminantPPM
        //WaterReport.Next_Id = _id
        id = _id
        date_time = _dateTime
        location = place
        email = emailAddress
    }
    
    convenience init() {
        let model = Model.instance
        self.init(_id: model.getHighesPurityId() + 1, _reporter: Account(), _condition: "", _viralPPM: 0, _contaminantPPM: 0, _dateTime: "", place: Location(lat: 0, longit: 0), emailAddress: "")
    }
    
    convenience init(_reporter: Account, _condition: String, _viralPPM: Int, _contaminantPPM: Int, _dateTime: String, place: Location, emailAddress: String) {
        let model = Model.instance
        //WaterReport.Next_Id = WaterReport.Next_Id + 1
        self.init(_id: model.getHighesPurityId() + 1, _reporter: _reporter, _condition: _condition, _viralPPM: _viralPPM, _contaminantPPM: _contaminantPPM, _dateTime: _dateTime, place: place, emailAddress: emailAddress)
    }
    
    func getReporter() -> Account {
        return reporter
    }
    
    func setReporter(newReporter: Account) {
        reporter = newReporter
    }
    
    func getId() -> Int {
        return id
    }
    
    func setId(newId: Int) {
        id = newId
    }
    
    func getDateTime() -> String {
        return date_time
    }
    
    func getEmail() -> String {
        return email
    }
    
    func setDateTime(newDateTime: String) {
        date_time = newDateTime
    }
    
    func getLocation() -> Location {
        return location
    }
    
    func setLocation(newLocation: Location) {
        location = newLocation
    }
    
    
    func getCondition() -> String {
        return condition
    }
    
    func getConditions() -> [String] {
        return waterCondition
    }
    
    func getViralPPM() -> Int {
        return viralPPM
    }
    
    func setViralPPM(newViralPPM: Int) {
        viralPPM = newViralPPM
    }
    
    func getContaminantPPM() -> Int {
        return contaminantPPM
    }
    
    func setContaminantPPM(newContaminantPPM: Int) {
        contaminantPPM = newContaminantPPM
    }

    
    class func setCondition(newCondition: String) -> String {
        let waterCondition: [String] = ["Safe", "Treatable", "Unsafe"]
        if (waterCondition.contains(newCondition)) {
            return newCondition;
            //condition = newCondition
        }
        return ""
    }
    
    func toString() -> String {
        return "Report No.: \(self.getId()) Reporter: \(self.getEmail()) \n \(condition) \n ViralPPM: \(viralPPM) ContaminantPPM:\(contaminantPPM) \n Location: \(location.toString())"
    }
    
    func isEqual(object: AnyObject?) -> Bool {
        let object = object as? WaterPurityReport
        if (object?.getReporter() === reporter && object?.getCondition() == condition
            && object?.getId() == id && object?.getContaminantPPM() == contaminantPPM && object?.getViralPPM() == viralPPM
            && object?.getLocation() === location) {
            return true
        } else {
            return false
        }
    }
    
    func toAnyObject() -> Dictionary<String, String> {
        return ["conditon":self.getCondition(), "contaminantPPM":String(self.getContaminantPPM()), "dateTime":self.getDateTime(), "id":String(self.getId()), "latitude":String(self.getLocation().getLatitude()), "longitude":String(self.getLocation().getLongitude()), "emailAddress":self.getEmail(), "viralPPM":String(self.getViralPPM())]
    }
    
}

func == (lhs: WaterPurityReport, rhs: WaterPurityReport) -> Bool {
    if (rhs.getReporter() === lhs.getReporter() && rhs.getCondition() == lhs.getCondition()
         && rhs.getId() == lhs.getId() && rhs.getViralPPM() == lhs.getViralPPM() && rhs.getContaminantPPM() == lhs.getContaminantPPM()
        && rhs.getLocation() === lhs.getLocation()) {
        return true
    }
    return false
}

