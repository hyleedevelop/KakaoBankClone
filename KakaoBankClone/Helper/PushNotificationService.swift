//
//  PushNotificationService.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/09/15.
//

import UIKit
import FirebaseFirestore

enum TransactionType {
    case send
    case receive
}

final class PushNotificationService {

    static let shared = PushNotificationService()
    private init () {}

    //MARK: - 속성

    // Firestore의 인스턴스
    private let firestore = Firestore.firestore()

    //MARK: - 메서드

    // 로컬 푸시 알림 보내기
    func requestLocalPushNotification(
        type: TransactionType, sender: String, receiver: String, amount: Int,
        myAccountName: String, myAccountNumber: String, myAccountBalance: Int
    ) {
        // 푸시 알림 메세지의 제목 및 내용 구성
        //
        // 1. 입금 메세지 예시
        // 제목) 입금 100,000원
        // 내용) 이호연 → 내 공과금통장(4680)
        //      잔액 3,500,000원
        //
        // 2. 출금 메세지 예시
        // 제목) 출금 100,000원
        // 내용) 내 공과금통장(4680) → 박민성
        //      잔액 3,500,000원

        let content = UNMutableNotificationContent()
        var title: String
        var body : String

        switch type {
        case .send:
            title = "출금 \((amount).commaSeparatedWon)원"
            body = "내 \(myAccountName)(\(myAccountNumber.dropFirst(6)))" + " → " + receiver +
            "\n" + "잔액 \((myAccountBalance - amount).commaSeparatedWon)원"
        case .receive:
            title = "입금 \((amount).commaSeparatedWon)원"
            body = sender + " → " + "내 \(myAccountName)(\(myAccountNumber.dropFirst(6)))" +
            "\n" + "잔액 \((myAccountBalance + amount).commaSeparatedWon)원"
        }

        content.title = title
        content.body = body
        content.interruptionLevel = .critical
        content.userInfo = ["content-available": 1]

        // 주어진 시간동안 푸시 알림 보이기
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    
    
    
//    // 입금 푸시 알림 보여주기
//    func presentIncomePushNotification(
//        myAccountName: String, myAccountNumber: String, myAccountBalance: Int,
//        completion: @escaping () -> Void
//    ) {
//        // 리스너 등록 후 첫번째로 실행되는지의 여부 (앱 최초 실행 시 리스너가 등록됨과 동시에 클로저 내부 코드가 한번 실행됨)
//        var isFirstListenerCall = true
//
//        self.firestore
//            .collection("transaction")
//            .addSnapshotListener { querySnapshot, error in
//                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching documents: \(error ?? "Unknown error" as! Error)")
//                    return
//                }
//
//                // 리스너 등록 후 첫번째는 아래의 코드를 실행하지 않음
//                guard !isFirstListenerCall else {
//                    isFirstListenerCall.toggle()
//                    return
//                }
//
//                // 가장 마지막 문서(가장 최신의 이체내역) 가져오기
//                guard let document = documents.last else { return }
//
//                // 새로운 문서(이체 거래)가 추가될 때마다 실행할 코드 작성
//                guard let sender = document.get("sender") as? String,
//                      let receiver = document.get("receiver") as? String,
//                      let amount = document.get("amount") as? Int else { return }
//
//                // 현재 로그인한 사용자의 ID가 계좌이체 수신자의 ID와 일치할 때만 입금 푸시 알림 처리하기
//                if UserDefaults.standard.userID == receiver {
//                    self.requestLocalPushNotification(
//                        mode: .receive, sender: sender, receiver: receiver, amount: amount,
//                        myAccountName: myAccountName, myAccountNumber: myAccountNumber, myAccountBalance: myAccountBalance
//                    )
//                }
//
//                completion()
//            }
//    }
//
//    // 출금 푸시 알림 보여주기
//    func presentOutcomePushNotification(
//        myAccountName: String, myAccountNumber: String, myAccountBalance: Int,
//        completion: @escaping () -> Void
//    ) {
//        // 리스너 등록 후 첫번째로 실행되는지의 여부 (앱 최초 실행 시 리스너가 등록됨과 동시에 클로저 내부 코드가 한번 실행됨)
//        var isFirstListenerCall = true
//
//        self.firestore
//            .collection("transaction")
//            .addSnapshotListener { querySnapshot, error in
//                guard let documents = querySnapshot?.documents else {
//                    print("Error fetching documents: \(error ?? "Unknown error" as! Error)")
//                    return
//                }
//
//                // 리스너 등록 후 첫번째는 아래의 코드를 실행하지 않음
//                guard !isFirstListenerCall else {
//                    isFirstListenerCall.toggle()
//                    return
//                }
//
//                // 가장 마지막 문서(가장 최신의 이체내역) 가져오기
//                guard let document = documents.last else { return }
//
//                // 새로운 문서(이체 거래)가 추가될 때마다 실행할 코드 작성
//                guard let sender = document.get("sender") as? String,
//                      let receiver = document.get("receiver") as? String,
//                      let amount = document.get("amount") as? Int else { return }
//
//                // 현재 로그인한 사용자의 ID가 계좌이체 발신자의 ID와 일치할 때만 출금 푸시 알림 처리하기
//                if UserDefaults.standard.userID == sender {
//                    self.requestLocalPushNotification(
//                        mode: .send, sender: sender, receiver: receiver, amount: amount,
//                        myAccountName: myAccountName, myAccountNumber: myAccountNumber, myAccountBalance: myAccountBalance
//                    )
//                }
//
//                completion()
//            }
//    }
    
}
