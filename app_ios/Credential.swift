//
//  Credential.swift
//  app_ios
//
//  Created by Nicholas Giammanco on 2/28/17.
//  Copyright © 2017 Nicholas Giammanco. All rights reserved.
//

import Foundation

internal enum Credential: String {
    case USER  = "USER"
    case WORKER = "WORKER"
    case MANAGER   = "MANAGER"
    case ADMIN  = "ADMIN"
    case NULL = "NULL"
    
}

extension Credential {
    init?(cred: String) {
        switch cred.lowercased() {
        case "user": self = .USER
        case "worker": self = .WORKER
        case "manager": self = .MANAGER
        case "admin": self = .ADMIN
        case "null": self = .NULL
        default: return nil
        }
    }
    
    func identify() -> Credential {
        return self
    }
    
    func toString() -> String {
        return self.rawValue
    }
}
