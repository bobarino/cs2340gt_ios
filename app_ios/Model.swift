//
//  Model.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 2/28/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation
import Firebase

class Model {
    
    static let instance = Model()
    var ref: FIRDatabaseReference!
    
    /*func getInstance() -> Model {
        return .instance
    }*/
    func setup_accounts(model: Model) -> Bool {
        ref = FIRDatabase.database().reference()
        ref.child("accounts_ios").observeSingleEvent(of: .value, with: { snapshot in
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if let snapDict = rest.value as? Dictionary<String, AnyObject> {
                    var id = 0
                    var cred = Credential.USER
                    var email = ""
                    var pass = ""
                    for each in snapDict {
                        if (each.key == "emailAddress") {
                            email = each.value as! String
                        } else if (each.key == "password") {
                            pass = each.value as! String
                        } else if (each.key == "id") {
                            let id_string = each.value as! String
                            id = Int(id_string)!
                        } else if (each.key == "credential") {
                            cred = Credential(cred: each.value as! String)!
                        }
                    }
                    let dbAcc = Account(id: id, emailAddress: email, password: pass, cred: cred)
                    if(model.addAccountInfo(newAcc: dbAcc)) {
                        print("Account: \(email) created")
                    } else {
                        print("Error adding Account")
                    }
                }
            }
        })
        setup_reports(model: model)
        return true
    }
    
    func setup_reports(model: Model) -> Bool {
       // if (model.accountList.count > 0) {
            print("WE HAVE ACCOUNTS")
        ref = FIRDatabase.database().reference()
        ref.child("reports_ios").observeSingleEvent(of: .value, with: { snapshot in
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if let snapDict = rest.value as? Dictionary<String, AnyObject> {
                    var id = 0
                    var condition = ""
                    var dateTime = ""
                    var email = ""
                    var latitude = 0.0
                    var longitude = 0.0
                    var source = ""
                    for each in snapDict {
                        if (each.key == "condition") {
                            condition = each.value as! String
                        } else if (each.key == "dateTime") {
                            dateTime = each.value as! String
                        } else if (each.key == "id") {
                            let id_string = each.value as! String
                            id = Int(id_string)!
                        } else if (each.key == "latitude") {
                            let lat = each.value as! String
                            latitude = Double(lat)!
                        } else if (each.key == "longitude") {
                            let long = each.value as! String
                            longitude = Double(long)!
                        } else if (each.key == "source") {
                            source = each.value as! String
                        } else if (each.key == "emailAddress") {
                            email = each.value as! String
                        }
                    }
                    let dbRep = WaterReport(_id: id, _reporter: model.findAccountByEmail(email: email), _source: source, _condition: condition, _dateTime: dateTime, place: Location(lat: latitude, longit: longitude))
                    if (model.addReport(newReport: dbRep)) {
                        print("Report: \(id) created")
                    } else {
                        print("Error adding Report")
                    }
                }
                
            }
        })
       // }
        return true
    }
    
    var accountList = [Account]()
    
    func getAccountList() -> [Account] {
        return accountList
    }
    
    var reportList: [WaterReport]
     
     func getReportList() -> [WaterReport] {
        return reportList
     }
    
    static var currentAccount = Account()
    var currentReport: WaterReport?
    static var nextReportId = 1
    
    func getNextReportId() -> Int {
        return Model.nextReportId
    }
    
    func getCurrentReport() -> WaterReport {
        return currentReport!
    }
    
    func setCurrentReport(currentReport: WaterReport) {
        self.currentReport = currentReport
    }
    
    func getCurrentAccount() -> Account {
        return Model.currentAccount
    }
    
    func setCurrentAccount(currentAccount: Account) {
        Model.currentAccount = currentAccount
    }
    
    let nullAcc = Account()
    
    init() {
        accountList = [Account]()
        reportList = [WaterReport]()
    }
    
    func addAccountInfo(newAcc: Account) -> Bool {
        for account in accountList {
            if (newAcc.getEmailAddress() == account.getEmailAddress()) {
                return false;
            }
        }
        accountList.append(newAcc)
        return true;
    }
    
    func editAccountInfo(account: Account) -> Bool {
        let existing = findAccountById(id: account.getId())
        if (existing.getCredential() == Credential.NULL) {
            return false
        }
        existing.setEmailAddress(emailAddress: account.getEmailAddress())
        existing.setPassword(password: account.getPassword())
        existing.setCredential(cred: account.getCredential())
        return true
        
    }
    
    func addReport(newReport: WaterReport) -> Bool {
        if (newReport.getLocation().getLatitude() > 90 ||
            newReport.getLocation().getLatitude() < -90 ||
            newReport.getLocation().getLongitude() > 180 ||
            newReport.getLocation().getLongitude() < -180) {
            return false
        } else if(reportList.contains(newReport)) {
            return false
        }
        reportList.append(newReport)
        return true;
    }
    
    func findAccountById(id: Int) -> Account {
        for account in accountList {
            if (account.getId() == id) {
                return account
            }
        }
        return nullAcc
    }
    
    func findAccountByEmail(email: String) -> Account {
        for account in accountList {
            if (account.getEmailAddress() == email) {
                return account
            }
        }
        return nullAcc
    }
    
    //findReportBySubmitter,id,source,condition
    
    
}
