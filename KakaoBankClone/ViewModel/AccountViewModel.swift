//
//  AccountViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class AccountViewModel {
    
    //MARK: - 데이터
    
    let accountData: [AccountData] = [
        AccountData(
            backgroundColor: UIColor(themeColor: .yellow),
            tintColor: UIColor(themeColor: .black),
            name: "현금창고",
            hasSafeBox: true,
            accountBalance: 375_000,
            safeBoxBalance: 5_000_000
        ),
        AccountData(
            backgroundColor: UIColor(themeColor: .pink),
            tintColor: UIColor(themeColor: .white),
            name: "적금",
            hasSafeBox: true,
            accountBalance: 3_500_000,
            safeBoxBalance: 0
        ),
        AccountData(
            backgroundColor: UIColor(themeColor: .blue),
            tintColor: UIColor(themeColor: .white),
            name: "예금",
            hasSafeBox: true,
            accountBalance: 10_000_000,
            safeBoxBalance: 0
        ),
        AccountData(
            backgroundColor: UIColor(themeColor: .green),
            tintColor: UIColor(themeColor: .white),
            name: "저금통",
            hasSafeBox: true,
            accountBalance: 50_000,
            safeBoxBalance: 0
        ),
    ]
    
    let accountTopAdData: [AccountTopAdData] = [
        AccountTopAdData(
            title: "뜨거운 여름, 쿨한 혜택!",
            subtitle: "최대 6만원 혜택 챙기기",
            image: UIImage(named: "krw-money")!
        ),
        AccountTopAdData(
            title: "뜨거운 여름, 쿨한 혜택!",
            subtitle: "최대 6만원 혜택 챙기기",
            image: UIImage(named: "krw-money")!
        ),
        AccountTopAdData(
            title: "뜨거운 여름, 쿨한 혜택!",
            subtitle: "최대 6만원 혜택 챙기기",
            image: UIImage(named: "krw-money")!
        ),
    ]
    
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
    let footerHeight: CGFloat = 40
    
    // cell 높이
    func cellHeight(at section: Int) -> CGFloat {
        return section == 1 ? 200 : 75
    }
    
    // custom header view
    func headerInSection(tableView: UITableView, at section: Int) -> UIView? {
        let yPosition: CGFloat = section == 0 ? 20 : 10
        let titleLabel = UILabel(frame: CGRect(
            x: 10, y: yPosition, width: tableView.frame.width, height: 18
        ))
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor.black
        titleLabel.text = "카카오뱅크 클론앱입니다."
        
        let headerView = UIView()
        headerView.addSubview(titleLabel)
        headerView.backgroundColor = .systemGray6
        
        return headerView
    }
    
    // custom footer view
    func footerInSection(tableView: UITableView, at section: Int) -> UIView? {
        let separatorView = UIView(frame: CGRect(
            x: -20, y: 20, width: tableView.frame.width, height: 1
        ))
        separatorView.backgroundColor = UIColor.systemGray5
        
        let footerView = UIView()
        footerView.addSubview(separatorView)
        
        return section == self.numberOfSections-1 ? nil : footerView
    }
    
//    // cell 아이템 제목
//    func cellItemTitle(indexPath: IndexPath) -> String {
//        return self.moreCellData[indexPath.section][indexPath.row].title
//    }
//    
//    // cell 아이템 값
//    func cellItemValue(indexPath: IndexPath) -> String {
//        return self.moreCellData[indexPath.section][indexPath.row].value ?? ""
//    }
//    
//    // 텍스트 정보
//    private func titleForHeaderInSection(at section: Int) -> String? {
//        switch MoreCellSection(rawValue: section) {
//        case .appSettings:
//            return K.More.appSettingsTitle
//        case .feedback:
//            return K.More.feedbackTitle
//        case .aboutTheApp:
//            return K.More.aboutTheAppTitle
//        case .none:
//            return nil
//        }
//    }
    
}
