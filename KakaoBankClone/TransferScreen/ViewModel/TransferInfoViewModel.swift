//
//  TransferInfoViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/20.
//

import UIKit
import FirebaseFirestore

final class TransferInfoViewModel {
    
    //MARK: - 생성자
    
    init(
        accountName: String,
        accountNumber: String,
        currentBalance: Int,
        selectedReceiverName: String,
        selectedReceiverAccount: String
    ) {
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.currentBalance = currentBalance
        self.selectedReceiverName = selectedReceiverName
        self.selectedReceiverAccount = selectedReceiverAccount
    }
    
    //MARK: - 계좌 정보 관련
    
    var accountName: String
    var accountNumber: String
    var currentBalance: Int
    var selectedReceiverName: String
    var selectedReceiverAccount: String
    
    //MARK: - UI 관련
    
    // 키패드 버튼 제목
    let keypadButtonTitles: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "00", "0", "<-"]
    
    // 보낼금액 추가 버튼 제목
    let addAmountButtonTitles: [String] = ["+1만", "+5만", "+10만", "전액"]
    
}
