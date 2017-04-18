//
//  WaterReport.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/27/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation

class WaterReport: Equatable {
    
    static var Next_Id = 0
    
    var reporter: Account
    var date_time: String
    var id: Int
    var condition: String
    var waterSources: [String] = ["Bottled", "Well", "Stream", "Lake", "Spring", "Other"]
    var waterCondition: [String] = ["Waste", "Treatable - Muddy", "Treatable - Clear", "Potable"]
    var location: Location
    var source: String
    
    init(_id: Int, _reporter: Account, _source: String, _condition: String, _dateTime: String, place: Location) {
        reporter = _reporter
        condition = WaterReport.setCondition(newCondition: _condition)
        source = WaterReport.setSource(newSource: _source)
        WaterReport.Next_Id = _id
        id = WaterReport.Next_Id
        date_time = _dateTime;
        location = place;
    }
    
    convenience init() {
        self.init(_id: WaterReport.Next_Id + 1, _reporter: Account(), _source: "", _condition: "", _dateTime: "", place: Location(lat: 0, longit: 0))
    }
    
    convenience init(_reporter: Account, _source: String, _condition: String, _dateTime: String, place: Location) {
        WaterReport.Next_Id = WaterReport.Next_Id + 1
        self.init(_id: WaterReport.Next_Id, _reporter: _reporter, _source: _source, _condition: _condition, _dateTime: _dateTime, place: place)
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
    
    func setDateTime(newDateTime: String) {
        date_time = newDateTime
    }
    
    func getLocation() -> Location {
        return location
    }
    
    func setLocation(newLocation: Location) {
        location = newLocation
    }
    
    func getSource() -> String {
        return source
    }
    
    func getSources() -> [String] {
        return waterSources
    }
    
    class func setSource(newSource: String) -> String {
        let waterSources: [String] = ["Bottled", "Well", "Stream", "Lake", "Spring", "Other"]
        if (waterSources.contains(newSource)) {
            return newSource;
            //source = newSource
        }
        return ""
    }
    
    func getCondition() -> String {
        return condition
    }
    
    func getConditions() -> [String] {
        return waterCondition
    }
    
    class func setCondition(newCondition: String) -> String {
        let waterCondition: [String] = ["Waste", "Treatable - Muddy", "Treatable - Clear", "Potable"]
        if (waterCondition.contains(newCondition)) {
            return newCondition;
            //condition = newCondition
        }
        return ""
    }
    
    func toString() -> String {
        return "Report No.: \(self.getId()) \(self.getReporter().getEmailAddress()) \n - \(condition) - \(source) \n Location: \(location.toString())"
    }
    
    func isEqual(object: AnyObject?) -> Bool {
        let object = object as? WaterReport
        if (object?.getReporter() === reporter && object?.getCondition() == condition
            && object?.getSource() == source && object?.getId() == id
            && object?.getLocation() === location) {
            return true
        } else {
            return false
        }
    }
    
    func toAnyObject() -> Dictionary<String, String> {
        return ["conditon":self.getCondition(), "dateTime":self.getDateTime(), "id":String(self.getId()), "latitude":String(self.getLocation().getLatitude()), "longitude":String(self.getLocation().getLongitude()), "emailAddress":self.getReporter().getEmailAddress(), "source":self.getSource()]
    }
    
}

func == (lhs: WaterReport, rhs: WaterReport) -> Bool {
    if (rhs.getReporter() === lhs.getReporter() && rhs.getCondition() == lhs.getCondition()
        && rhs.getSource() == lhs.getSource() && rhs.getId() == lhs.getId()
        && rhs.getLocation() === lhs.getLocation()) {
        return true
    }
    return false
}
