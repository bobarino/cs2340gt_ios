//
//  Model.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 2/28/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation

class Model {
    
    static let instance = Model()
    
    func getInstance() -> Model {
        return .instance
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
            if (newAcc.equals(account: account)) {
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
