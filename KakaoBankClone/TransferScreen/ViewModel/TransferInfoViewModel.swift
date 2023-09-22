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
    
    //MARK: - Firestore 관련
    
    // 거래내역 히스토리 데이터를 Firestore에 저장하기
    func createTransactionHistory(amount: Int, completion: @escaping () -> Void) {
        // 보내는 사람의 계좌 잔고 최신값을 Firebase에서 가져오기
        self.getAccountBalance(type: .send) { senderAccountBalance in
            // Firestore DB 업데이트: 보내는 사람의 계좌 잔고 감소 (-)
            self.firestore
                .collection("users")
                .document(UserDefaults.standard.userID)
                .updateData([
                    "accountBalance": senderAccountBalance - amount
                ]) { error in
                    if let error = error { print(error.localizedDescription) }
                }
        }
        
        // 받는 사람의 계좌 잔고 최신값을 Firebase에서 가져오기
        self.getAccountBalance(type: .receive) { receiverAccountBalance in
            // Firestore DB 업데이트: 받는 사람의 계좌 잔고 증가 (+)
            self.firestore
                .collection("users")
                .document(self.selectedReceiverID)
                .updateData([
                    "accountBalance": receiverAccountBalance + amount
                ]) { error in
                    if let error = error { print(error.localizedDescription) }
                }
        }
        
        // Firestore DB 추가: 거래내역 저장
        self.firestore
            .collection("transaction")
            .document(String(Date().timeIntervalSince1970))
            .setData([
                "senderID": UserDefaults.standard.userID,
                "senderName": self.userName,
                "receiverID": self.selectedReceiverID,
                "receiverName": self.selectedReceiverName,
                "amount": amount,
                "time": Date().timeIntervalSince1970
            ]) { error in
                if let error = error { print(error.localizedDescription) }
            }
        
        completion()
    }
    
    // 계좌 잔고 조회
    private func getAccountBalance(type: TransactionType, completion: @escaping (Int) -> Void) {
        self.firestore
            .collection("users")
            .document(type == .send ? UserDefaults.standard.userID : self.selectedReceiverID)
            .getDocument { document, error in
                if let document = document, document.exists {
                    guard let balance = document.get("accountBalance") as? Int else { return }
                    completion(balance)
                } else {
                    print("Firestore로부터 데이터를 읽어오는데 실패했습니다.")
                }
            }
    }
    
}
