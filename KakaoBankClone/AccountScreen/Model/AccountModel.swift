//
//  AccountData.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/05.
//

import UIKit

struct AccountModel {
    let backgroundColor: UIColor
    let tintColor: UIColor
    let userID: String
    let userName: String
    let bank: String
    let accountName: String
    let accountNumber: String
    var accountBalance: Int
    let hasSafeBox: Bool
    let safeBoxBalance: Int
}
