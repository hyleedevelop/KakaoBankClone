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
    
    // 출금 푸시 알림 보여주기
//    func showOutcomePushNotification(completion: @escaping () -> Void) {
//        // 리스너 등록 후 첫번째로 실행되는지의 여부 (앱 최초 실행 시 리스너가 등록됨과 동시에 클로저 내부 코드가 한번 실행됨)
//        var isFirstListenerCall = true
//
//        if isFirstListenerCall {
//            self.firestore
//                .collection("transaction")
//                .addSnapshotListener { querySnapshot, error in
//                    guard let documents = querySnapshot?.documents else {
//                        print("Error fetching documents: \(error ?? "Unknown error" as! Error)")
//                        return
//                    }
//
//                    // 리스너 등록 후 첫번째는 아래의 코드를 실행하지 않음
//                    // 계좌 화면이 처음 나타났을 때, 가장 마지막 거래내역에 대한 푸시 알림이 보여지는 것을 방지함
//                    if isFirstListenerCall {
//                        isFirstListenerCall = false
//                    } else {
//                        // 가장 마지막 문서(가장 최신의 이체내역) 가져오기
//                        guard let document = documents.last else { return }
//                        // 새로운 문서(이체 거래)가 추가될 때마다 실행할 코드 작성
//                        guard let sender = document.get("sender") as? String,
//                              let receiver = document.get("receiver") as? String,
//                              let amount = document.get("amount") as? Int else { return }
//
//                        // 현재 로그인한 사용자의 ID가 계좌이체 발신자의 ID와 일치할 때만 출금 푸시 알림 처리하기
//                        if UserDefaults.standard.userID == sender {
//                            self.requestLocalPushNotification(
//                                sender: sender,
//                                receiver: receiver,
//                                amount: amount
//                            )
//                        }
//
//                        completion()
//                    }
//                }
//        }
//    }
//
//    // 로컬 푸시 알림 보내기
//    func requestLocalPushNotification(sender: String, receiver: String, amount: Int) {
//        // 푸시 알림 메세지의 제목 및 내용 구성
//        // 제목 예시) 출금 100,000원
//        // 내용 예시) 내 공과금통장(4680) → 박민성
//        //          잔액 3,500,000원
//        let content = UNMutableNotificationContent()
//        let title = "출금 \((amount).commaSeparatedWon)원"
//        let body = "내 \(self.accountName)(\(self.accountNumber.dropFirst(6)))" + " → " + receiver +
//                   "\n" + "잔액 \((self.currentBalance - amount).commaSeparatedWon)원"
//
//        content.title = title
//        content.body = body
//        content.interruptionLevel = .critical
//        content.userInfo = ["content-available": 1]
//
//        // 주어진 시간동안 푸시 알림 보이기
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString,
//                                            content: content,
//                                            trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
    
}
