//
//  UserDefaults.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/18.
//

import Foundation

extension UserDefaults {
    
    // 사용자의 ID
    var userID: String {
        get {
            return self.object(forKey: "userID") as? String ?? "user1"
        }
        set {
            return self.setValue(newValue, forKey: "userID")
        }
    }
    
    // 계좌 화면에서 테이블뷰 셀 애니메이션을 보여줄지의 여부
    var showCellAnimation: Bool {
        get {
            return self.object(forKey: "showCellAnimation") as? Bool ?? true
        }
        set {
            return self.setValue(newValue, forKey: "showCellAnimation")
        }
    }
    
}
