//
//  WaterReport.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 3/27/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation

class WaterReport {
    
    var reporter: Account
    var date_time: String
    var id: Int
    var condition: String
    var waterSources: [String] = ["Bottled", "Well", "Stream", "Lake", "Spring", "Other"]
    var waterCondition: [String] = ["Waste", "Treatable - Muddy", "Treatable - Clear", "Potable"]
    var location: Location
    var source: String
    
    init(_reporter: Account, _source: String, _condition: String, _dateTime: String, place: Location) {
        reporter = _reporter
        setCondition(newCondition: _condition)
        setSource(newSource: _source);
        id = Model.getNextReportId();
        date_time = _dateTime;
        location = place;
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
    
    func setSource(newSource: String) {
        if (waterSources.contains(newSource)) {
            source = newSource
        }
    }
    
    func getCondition() -> String {
        return condition
    }
    
    func setCondition(newCondition: String) {
        if (waterCondition.contains(newCondition)) {
            condition = newCondition
        }
    }
    
    func toString() -> String {
        return "Report No.: \(id) \(reporter.getEmailAddress()) \n - \(condition) - \(source) \n Location: \(location)"
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
    
}
