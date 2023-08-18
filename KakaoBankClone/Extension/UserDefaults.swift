//
//  UserDefaults.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/18.
//

import Foundation

extension UserDefaults {
    
    var userID: String {
        get {
            return self.object(forKey: "userID") as? String ?? "user1"
        }
        set {
            return self.setValue(newValue, forKey: "userID")
        }
    }
    
}
