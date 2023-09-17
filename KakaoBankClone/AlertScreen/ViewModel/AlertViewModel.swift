//
//  AlertViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import FirebaseFirestore

final class AlertViewModel {
    
    //MARK: - Firestore 및 데이터
    
    // Firestore의 인스턴스
    private let firestore = Firestore.firestore()
    
    // 알림 데이터
    private var alertData = [AlertModel]()
    
    // Firestore에서 거래 데이터 가져오기
    func fetchTransactionDataFromServer(completion: @escaping () -> Void) {
        // 데이터 한번 가져오기 (addSnapshotListener와는 다름)
        self.firestore
            .collection("transaction")
            .order(by: "time", descending: true)
            .getDocuments { querySnapshot, error in
                for document in querySnapshot!.documents {
                    guard let amount = document.data()["amount"] as? Int,
                          let senderName = document.data()["senderName"] as? String,
                          let senderID = document.data()["senderID"] as? String,
                          let receiverName = document.data()["receiverName"] as? String,
                          let receiverID = document.data()["receiverID"] as? String,
                          let time = document.data()["time"] as? Double else { return }
                    
                    // 현재 로그인한 사용자가 거래 내역에 연관되어 있는 경우
                    // 데이터 배열에 추가
                    if UserDefaults.standard.userID == senderID || UserDefaults.standard.userID == receiverID {
                        self.alertData.append(
                            AlertModel(
                                amount: amount,
                                senderName: senderName,
                                senderID: senderID,
                                receiverName: receiverName,
                                receiverID: receiverID,
                                time: time
                            )
                        )
                    }
                }
                
                completion()
            }
    }
        
    // 스냅샷 리스너 설정하기
    func setupSnapshotListenerForAlertList(completion: @escaping () -> Void) {
        // 리스너 등록 후 첫번째로 실행되는지의 여부 (앱 최초 실행 시 리스너가 등록됨과 동시에 클로저 내부 코드가 한번 실행됨)
        var isFirstListenerCall = true
        
        // 실시간으로 자료를 업데이트 하고 데이터 가져오기 (addSnapshotListener)
        self.firestore
            .collection("transaction")
            .order(by: "time", descending: true)
            .addSnapshotListener { querySnapshot, error in
                // 에러 발생 여부 확인
                guard error == nil else { return }
                
                // 리스너 등록 후 1회에 한해 아래의 코드를 실행하지 않음
                // 계좌 화면이 처음 나타났을 때, 가장 마지막 거래내역에 대한 푸시 알림이 보여지는 것을 방지함
                if isFirstListenerCall {
                    isFirstListenerCall = false
                } else {
                    // 데이터 배열 초기화
                    self.alertData.removeAll()
                    
                    // 가져오는데 성공한 경우
                    for document in querySnapshot!.documents {
                        guard let amount = document.data()["amount"] as? Int,
                              let senderName = document.data()["senderName"] as? String,
                              let senderID = document.data()["senderID"] as? String,
                              let receiverName = document.data()["receiverName"] as? String,
                              let receiverID = document.data()["receiverID"] as? String,
                              let time = document.data()["time"] as? Double else { return }
                        
                        // 현재 로그인한 사용자가 거래 내역에 연관되어 있는 경우
                        // 데이터 배열에 추가
                        if UserDefaults.standard.userID == senderID || UserDefaults.standard.userID == receiverID {
                            self.alertData.append(
                                AlertModel(
                                    amount: amount,
                                    senderName: senderName,
                                    senderID: senderID,
                                    receiverName: receiverName,
                                    receiverID: receiverID,
                                    time: time
                                )
                            )
                        }
                    }
                    
                    completion()
                }
            }
    }
    
    //MARK: - 테이블뷰
    
    // section의 개수
    let numberOfSections: Int = 1
    
    // section당 row의 개수
    var numberOfRowsInSection: Int {
        return self.alertData.count
    }
    
    // header 높이
    let heightForHeaderInSection: CGFloat = 50
    
    // cell 높이
    let heightForRow: CGFloat = 100
    
    // custom header view
    func viewForHeaderInSection(tableView: UITableView, at section: Int) -> UIView? {
        let titleLabel = UILabel(
            frame: CGRect(x: 25, y: 0, width: tableView.frame.width, height: 50)
        )
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor.black
        titleLabel.text = "이전 알림"
        
        let headerView = UIView()
        headerView.addSubview(titleLabel)
        headerView.backgroundColor = UIColor(themeColor: .white)
        headerView.layer.borderColor = UIColor.cyan.cgColor
        headerView.layer.borderWidth = 0
        
        return headerView
    }
    
    // custom footer view
    func viewForFooterInSection(at section: Int) -> UIView {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(themeColor: .white)
        return footerView
    }
    
    // 알림 데이터에서 보낸 사람의 ID 가져오기
    func getSenderID(at index: Int) -> String {
        return self.alertData[index].senderID
    }
    
    // 알림 데이터에서 보낸 사람의 이름 가져오기
    func getSenderName(at index: Int) -> String {
        return self.alertData[index].senderName
    }
    
    // 알림 데이터에서 받는 사람의 ID 가져오기
    func getReceiverID(at index: Int) -> String {
        return self.alertData[index].receiverID
    }
    
    // 알림 데이터에서 받는 사람의 이름 가져오기
    func getReceiverName(at index: Int) -> String {
        return self.alertData[index].receiverName
    }
    
    // 알림 로고 이미지 얻기
    func getAlertLogoImage(at index: Int) -> UIImage {
        return UIImage(systemName: "arrow.left.arrow.right")!
    }
    
    // 알림 제목 얻기
    func getAlertTitle(at index: Int) -> String {
        switch UserDefaults.standard.userID {
        case self.alertData[index].senderID:
            return "현금 출금"
        case self.alertData[index].receiverID:
            return "현금 입금"
        default:
            return ""
        }
    }
    
    // 알림 내용 얻기
    func getAlertContent(at index: Int) -> String {
        switch UserDefaults.standard.userID {
        case self.alertData[index].senderID:
            return "출금 " + "\(self.alertData[index].amount.commaSeparatedWon)" + "원" +
                   " | " + "\(self.alertData[index].receiverName)"
        case self.alertData[index].receiverID:
            return "입금 " + "\(self.alertData[index].amount.commaSeparatedWon)" + "원" +
                   " | " + "\(self.alertData[index].senderName)"
        default:
            return ""
        }
    }
    
    // 알림 날짜 얻기
    func getTransactionDate(at index: Int) -> String {
        let date = Date(timeIntervalSince1970: self.alertData[index].time)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "MM월 dd일"

        return dateFormatter.string(from: date)
    }
    
}
