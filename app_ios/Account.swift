//
//  Account.swift
//
//
//  Created by Nicholas Giammanco on 2/28/17.
//
//

import Foundation

class Account {
    
    static var Next_Id = 0
    
    var id: Int
    var emailAddress: String
    var password: String
    var cred: Credential
    
    // constructor for general use with proper indexing
    init(emailAddress: String, password: String, cred: Credential) {
        if (emailAddress == "null" && password == "null" && cred == Credential.NULL) {
            self.id = 9999
        } else {
            self.id = Account.Next_Id + 1
        }
        self.emailAddress = emailAddress
        self.password = password
        self.cred = cred
    }
    
    // ONLY for use with creating the null account
    convenience init() {
        self.init(emailAddress: "null", password: "null", cred: Credential.NULL)
    }
    
    func getEmailAddress() -> String {
        return emailAddress
    }
    
    func setEmailAddress(emailAddress: String) {
        self.emailAddress = emailAddress
    }
    
    func getPassword() -> String {
        return password
    }
    
    func setPassword(password: String) {
        self.password = password
    }
    
    func getCredential() -> Credential {
        return cred
    }
    
    func setCredential(cred: Credential) {
        self.cred = cred
    }
    
    func getId() -> Int {
        return id
    }
    
    func equals(account: Account) -> Bool {
        if (account.getEmailAddress() == emailAddress) {
            return true
        }
        return false
    }
    
    func toString() -> String {
        return emailAddress
    }
}
