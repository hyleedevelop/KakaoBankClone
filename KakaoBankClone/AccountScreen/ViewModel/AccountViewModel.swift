//
//  AccountViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import FirebaseFirestore

final class AccountViewModel {
    
    //MARK: - 생성자
    
    init() {
        // 상단 광고 컬렉션뷰에서 무한 스크롤 구현을 위해 앞과 뒤에 데이터를 추가 -> () 표시된 부분
        // 기존: 1 - 2 - 3
        // 변경: (3) - 1 - 2 - 3 - (1)
        self.accountTopAdData.insert(self.accountTopAdData[self.accountTopAdData.count-1], at: 0)
        self.accountTopAdData.append(self.accountTopAdData[1])
    }
    
    //MARK: - Firestore 및 데이터
    
    // Firestore의 인스턴스
    private let firestore = Firestore.firestore()
    
    // 계좌 정보 데이터
    private var accountData = [AccountModel]()
    
    // Firestore에서 사용자 데이터 가져오기
    func fetchAccountDataFromServer(userID: String, completion: @escaping ([AccountModel]) -> Void) {
        // 데이터 한번 가져오기 (addSnapshotListener와는 다름)
        self.firestore
            .collection("users")
            .document(userID)
            .getDocument { document, error in
                if let document = document, document.exists {
                    guard let userName = document.get("userName") as? String,
                          let userID = document.get("userID") as? String,
                          let bank = document.get("bank") as? String,
                          let accountName = document.get("accountName") as? String,
                          let accountNumber = document.get("accountNumber") as? String,
                          let accountBalance = document.get("accountBalance") as? Int,
                          let hasSafeBox = document.get("hasSafeBox") as? Bool,
                          let safeBoxBalance = document.get("safeBoxBalance") as? Int else { return }
                    
                    // 데이터 배열에 추가 (1)
                    self.accountData.append(
                        AccountModel(
                            backgroundColor: UIColor(themeColor: .yellow),
                            tintColor: UIColor(themeColor: .black),
                            userID: userID,
                            userName: userName,
                            bank: bank,
                            accountName: accountName,
                            accountNumber: accountNumber,
                            accountBalance: accountBalance,
                            hasSafeBox: hasSafeBox,
                            safeBoxBalance: safeBoxBalance
                        )
                    )
                    
                    let isTheFirstUser = UserDefaults.standard.userID == "user1"
                    
                    // 데이터 배열에 추가 (2)
                    self.accountData.append(
                        AccountModel(
                            backgroundColor: UIColor(themeColor: isTheFirstUser ? .pink : .blue),
                            tintColor: UIColor(themeColor: .white),
                            userID: userID,
                            userName: UserDefaults.standard.userID,
                            bank: "카카오뱅크",
                            accountName: "적금",
                            accountNumber: "222-222-222",
                            accountBalance: isTheFirstUser ? 3_500_000 : 1_200_000,
                            hasSafeBox: false,
                            safeBoxBalance: 0
                        )
                    )
                    self.accountData.append(
                        AccountModel(
                            backgroundColor: UIColor(themeColor: isTheFirstUser ? .blue : .green),
                            tintColor: UIColor(themeColor: .white),
                            userID: userID,
                            userName: UserDefaults.standard.userID,
                            bank: "카카오뱅크",
                            accountName: "예금",
                            accountNumber: "333-333-333",
                            accountBalance: isTheFirstUser ? 10_000_000 : 5_000_000,
                            hasSafeBox: false,
                            safeBoxBalance: 0
                        )
                    )
                    self.accountData.append(
                        AccountModel(
                            backgroundColor: UIColor(themeColor: isTheFirstUser ? .green : .pink),
                            tintColor: UIColor(themeColor: .white),
                            userID: userID,
                            userName: UserDefaults.standard.userID,
                            bank: "카카오뱅크",
                            accountName: "저금통",
                            accountNumber: "444-444-444",
                            accountBalance: isTheFirstUser ? 50_000 : 800_000,
                            hasSafeBox: false,
                            safeBoxBalance: 0
                        )
                    )
                    
                    completion(self.accountData)
                } else {
                    print("Firestore로부터 데이터를 읽어오는데 실패했습니다.")
                }
            }
    }
    
    // Firestore에서 갱신된 사용자 데이터 가져오기
    func fetchUpdatedAccountDataFromServer(userID: String, completion: @escaping (Int) -> Void) {
        self.firestore
            .collection("users")
            .document(userID)
            .getDocument { document, error in
                if let document = document, document.exists {
                    guard let accountBalance = document.get("accountBalance") as? Int else { return }
                    
                    // 계좌 잔고 갱신
                    self.accountData[0].accountBalance = accountBalance
                    
                    completion(accountBalance)
                } else {
                    print("Firestore로부터 데이터를 읽어오는데 실패했습니다.")
                }
            }
        
        // 실시간으로 자료를 업데이트 하고 데이터 가져오기 (addSnapshotListener)
//        self.firestore
//            .collection("users")
//            .order(by: "userID", descending: false)
//            .whereField("userID", isEqualTo: userID)
//            .addSnapshotListener { querySnapshot, error in
//                // 가져오는데 실패한 경우
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//
//                // 가져오는데 성공한 경우
//                for document in querySnapshot!.documents {
//                    guard let accountBalance = document.data()["accountBalance"] as? Int else { return }
//
//                    // 계좌 잔고 갱신
//                    self.accountData[0].accountBalance = accountBalance
//                    completion(accountBalance)
//                }
//
//                //completion(self.accountData[0].accountBalance)
//            }
    }
    
    // 사용자의 이름 가져오기
    func getUserName(userID: String) -> String {
        return self.accountData.first(where: { $0.userID == userID })?.userName ?? "익명"
    }
    
    // 사용자의 계좌 이름 가져오기
    func getAccountName(userID: String) -> String {
        return self.accountData.first(where: { $0.userID == userID})?.accountName ?? ""
    }
    
    // 사용자의 계좌 이름 가져오기
    func getAccountNumber(userID: String) -> String {
        return self.accountData.first(where: { $0.userID == userID})?.accountNumber ?? ""
    }
    
    // 사용자의 계좌 잔고 가져오기
    func getAccountBalance(userID: String) -> Int {
        return self.accountData.first(where: { $0.userID == userID})?.accountBalance ?? 0
    }
    
    // 세이프박스 포함 여부 확인
    func isAccountIncludeSafeBox(at index: Int) -> Bool {
        return self.accountData[index].hasSafeBox
    }
    
    var accountTopAdData: [AccountTopAdModel] = [
        AccountTopAdModel(title: "뜨거운 여름, 쿨한 혜택!", subtitle: "최대 6만원 혜택 챙기기", image: UIImage(named: "krw-money")!),
        AccountTopAdModel(title: "유학 생활 필수 거래외국환은행", subtitle: "카카오뱅크로 찜하면 무조건 3만원", image: UIImage(named: "krw-money")!),
        AccountTopAdModel(title: "안전 여행하면 환급되는 보험?", subtitle: "해외여행보험료 10% 돌려받기", image: UIImage(named: "krw-money")!),
    ]
    
    // 상단 광고 데이터 가져오기
    var getTopAdData: [AccountTopAdModel] {
        return self.accountTopAdData
    }
    
    // 사용자의 계좌 개수
    var numberOfAccountData: Int {
        return self.accountData.count
    }
    
    //MARK: - 네비게이션 바 관련
    
    let myAccountButtonName: String = "내 계좌"
    let myProfileImage: UIImage = UIImage(named: "flower")!
    
    //MARK: - 테이블뷰 관련
    
    // section의 개수
    let numberOfSections: Int = 3
    
    // section당 row의 개수
    func numberOfRowsInSection(at section: Int) -> Int {
        return section == 1 ? self.accountData.count : 1
    }
    
    // header 높이
    let headerHeight: CGFloat = 40
    
    // footer 높이
    func footerHeight(at section: Int) -> CGFloat {
        return section == 2 ? 40 : 0
    }
    
    // cell 높이
    func cellHeight(at section: Int, safeBox: Bool) -> CGFloat {
        if section == 1 {
            // 계좌 셀의 경우 세이프박스가 있으면 200, 없으면 120
            return safeBox == true ? 190 : 105
        } else {
            // 그 외의 나머지 셀은 75
            return 70
        }
    }
    
    // custom footer view
    func viewForFooterInSection(at section: Int) -> UIView? {
        return section == 2 ? UIView() : nil
    }
    
}
