//
//  TransferViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import FirebaseFirestore

final class ReceiverListViewModel {
    
    //MARK: - 생성자
    
    init(userName: String, accountName: String, accountNumber: String, currentBalance: Int) {
        self.userName = userName
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.currentBalance = currentBalance
    }
    
    //MARK: - Firestore 및 데이터
    
    // Firestore의 인스턴스
    private let firestore = Firestore.firestore()
    
    // 받는 사람의 계좌 정보 데이터
    private var receiverAccountData = [ReceiverListModel]()
    
    // 로그인한 사용자의 이름
    var userName: String
    
    // 로그인한 사용자의 현재 계좌 이름
    var accountName: String
    
    // 로그인한 사용자의 현재 계좌 번호
    var accountNumber: String
    
    // 로그인한 사용자의 현재 계좌 잔고
    var currentBalance: Int
    
    // Firestore에서 사용자 데이터 가져오기
    func fetchReceiverAccountDataFromServer(completion: @escaping ([ReceiverListModel]) -> Void) {
        // 실시간으로 자료를 업데이트 하고 데이터 가져오기 (addSnapshotListener)
        self.firestore
            .collection("users")
            .order(by: "userID", descending: false)
            .addSnapshotListener { querySnapshot, error in
            
            // 가져오는데 실패한 경우
            if let error = error {
                print(error.localizedDescription)
            }
            
            // 가져오는데 성공한 경우
            for document in querySnapshot!.documents {
                guard let userID = document.data()["userID"] as? String,
                      let userName = document.data()["userName"] as? String,
                      let accountNumber = document.data()["accountNumber"] as? String,
                      let accountBalance = document.data()["accountBalance"] as? Int else { return }
                
                // 데이터 배열에 추가
                self.receiverAccountData.append(
                    ReceiverListModel(
                        bankIcon: UIImage(systemName: "circle.fill")!,
                        receiverID: userID,
                        receiverName: userName,
                        receiverAccountNumber: accountNumber,
                        receiverAccountBalance: accountBalance
                    )
                )
            }
            
            completion(self.receiverAccountData)
        }
    }
    
    // 사용자 데이터에 접근
    func getReceiverAccountData(at index: Int) -> ReceiverListModel {
        return self.receiverAccountData[index]
    }
    
    //MARK: - 테이블뷰 관련
    
    // section의 개수
    let numberOfSections: Int = 1
    
    // section당 row의 개수
    var numberOfRowsInSection: Int {
        return self.receiverAccountData.count
    }
    
    // header 높이
//    let headerHeight: CGFloat = 40
    
    // footer 높이
//    func footerHeight(at section: Int) -> CGFloat {
//        return section == 2 ? 40 : 0
//    }
    
    // cell 높이
    let heightForRow: CGFloat = 70
    
    // custom footer view
//    func viewForFooterInSection(at section: Int) -> UIView? {
//        return section == 2 ? UIView() : nil
//    }
    
}
