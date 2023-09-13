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
        userName: String,
        accountName: String,
        accountNumber: String,
        currentBalance: Int,
        selectedReceiverID: String,
        selectedReceiverName: String,
        selectedReceiverAccount: String,
        selectedReceiverAccountBalance: Int
    ) {
        self.userName = userName
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.currentBalance = currentBalance
        self.selectedReceiverID = selectedReceiverID
        self.selectedReceiverName = selectedReceiverName
        self.selectedReceiverAccount = selectedReceiverAccount
        self.selectedReceiverAccountBalance = selectedReceiverAccountBalance
    }
    
    //MARK: - Firestore 및 데이터
    
    // Firestore의 인스턴스
    private let firestore = Firestore.firestore()
    
    var userName: String
    var accountName: String
    var accountNumber: String
    var currentBalance: Int
    var selectedReceiverID: String
    var selectedReceiverName: String
    var selectedReceiverAccount: String
    var selectedReceiverAccountBalance: Int
    
    //MARK: - UI 관련
    
    // 키패드 버튼 제목
    let keypadButtonTitles: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "00", "0", "<-"]
    
    // 보낼금액 추가 버튼 제목
    let addAmountButtonTitles: [String] = ["+1만", "+5만", "+10만", "전액"]
    
    //MARK: - 거래내역 생성 관련
    
    // 거래내역 히스토리 데이터를 Firestore에 저장하기
    func makeTransactionHistory(senderID: String, receiverID: String, amount: Int, completion: @escaping () -> Void) {
        // Firestore 업데이트: 보내는 사람의 계좌 잔고 감액 (-)
        self.firestore
            .collection("users")
            .document(UserDefaults.standard.userID)
            .updateData([
                "accountBalance": self.currentBalance - amount
            ]) { error in
                if let error = error { print(error.localizedDescription) }
            }
        
        // Firestore 업데이트: 받는 사람의 계좌 잔고 증액 (+)
        self.firestore
            .collection("users")
            .document(self.selectedReceiverID)
            .updateData([
                "accountBalance": self.selectedReceiverAccountBalance + amount
            ]) { error in
                if let error = error { print(error.localizedDescription) }
            }
        
        // Firestore 추가: Firestore에 거래내역 저장
        self.firestore
            .collection("transaction")
            .document(String(Date().timeIntervalSince1970))
            .setData([
                "sender": senderID,
                "receiver": receiverID,
                "amount": amount,
                "time": Date().timeIntervalSince1970
            ]) { error in
                if let error = error { print(error.localizedDescription) }
            }
        
        completion()
    }
    
}
