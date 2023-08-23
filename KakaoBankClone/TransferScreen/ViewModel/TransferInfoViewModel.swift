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
    
    init() {
        
    }
    
    //MARK: - Firestore 및 데이터
    
//    // Firestore의 인스턴스
//    private let firestore = Firestore.firestore()
//
//    // 계좌 정보 데이터
//    private var receiverAccountData = [ReceiverListModel]()
//
//    // Firestore에서 사용자 데이터 가져오기
//    func fetchReceiverAccountDataFromServer(completion: @escaping ([ReceiverListModel]) -> Void) {
//        // 실시간으로 자료를 업데이트 하고 데이터 가져오기 (addSnapshotListener)
//        self.firestore
//            .collection("users")
//            .order(by: "userID", descending: false)
//            .addSnapshotListener { querySnapshot, error in
//
//            // 가져오는데 실패한 경우
//            if let error = error {
//                print(error.localizedDescription)
//            }
//
//            // 가져오는데 성공한 경우
//            for document in querySnapshot!.documents {
//                guard let userName = document.data()["userName"] as? String,
//                      let accountNumber = document.data()["accountNumber"] as? String else { return }
//
//                // 데이터 배열에 추가
//                self.receiverAccountData.append(
//                    ReceiverListModel(
//                        bankIcon: UIImage(systemName: "circle.fill")!,
//                        receiverName: userName,
//                        receiverAccountNumber: accountNumber
//                    )
//                )
//            }
//
//            completion(self.receiverAccountData)
//        }
//
//    }
//
//    // 사용자 데이터에 접근
//    func getReceiverAccountData(at index: Int) -> ReceiverListModel {
//        return self.receiverAccountData[index]
//    }
    
    let currentBalance: Int = 1_000_000
    
    //MARK: - UI 관련
    
    // 키패드 버튼 제목
    let keypadButtonTitles: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "00", "0", "<-"]
    
    // 보낼금액 추가 버튼 제목
    let addAmountButtonTitles: [String] = ["+1만", "+5만", "+10만", "전액"]
    
}
