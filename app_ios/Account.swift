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
    init(id: Int, emailAddress: String, password: String, cred: Credential) {
        if (emailAddress == "null" && password == "null" && cred == Credential.NULL) {
            self.id = 9999
        } else {
            Account.Next_Id = id;
            self.id = Account.Next_Id
        }
        self.emailAddress = emailAddress
        self.password = password
        self.cred = cred
    }
    
    // ONLY for use with creating the null account
    convenience init() {
        self.init(id: 9999, emailAddress: "null", password: "null", cred: Credential.NULL)
    }
    
    convenience init(emailAddress: String, password: String, cred: Credential) {
        Account.Next_Id = Account.Next_Id + 1;
        self.init(id: Account.Next_Id, emailAddress: emailAddress, password: password, cred: cred)
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
    
    func toAnyObject() -> Dictionary<String, String> {
        return ["credential":self.getCredential().toString(), "emailAddress":self.getEmailAddress(), "id":String(self.getId()), "password":self.getPassword()]
    }
}
