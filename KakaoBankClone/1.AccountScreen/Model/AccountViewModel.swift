//
//  AccountViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class AccountViewModel {
    
    //MARK: - 생성자
    
    init() {
        // 상단 광고 컬렉션뷰에서 무한 스크롤 구현을 위해 앞과 뒤에 데이터를 추가 -> () 표시된 부분
        // 기존: 1 - 2 - 3
        // 변경: (3) - 1 - 2 - 3 - (1)
        self.accountTopAdData.insert(self.accountTopAdData[self.accountTopAdData.count-1], at: 0)
        self.accountTopAdData.append(self.accountTopAdData[1])
    }
    
    //MARK: - 데이터
    
    var accountTopAdData: [AccountTopAdModel] = [
        AccountTopAdModel(
            title: "뜨거운 여름, 쿨한 혜택!",
            subtitle: "최대 6만원 혜택 챙기기",
            image: UIImage(named: "krw-money")!
        ),
        AccountTopAdModel(
            title: "유학 생활 필수 거래외국환은행",
            subtitle: "카카오뱅크로 찜하면 무조건 3만원",
            image: UIImage(named: "krw-money")!
        ),
        AccountTopAdModel(
            title: "안전 여행하면 환급되는 보험?",
            subtitle: "해외여행보험료 10% 돌려받기",
            image: UIImage(named: "krw-money")!
        ),
    ]
    
    let accountData: [AccountModel] = [
        AccountModel(
            backgroundColor: UIColor(themeColor: .yellow),
            tintColor: UIColor(themeColor: .black),
            name: "현금창고",
            hasSafeBox: true,
            accountBalance: 375_000,
            safeBoxBalance: 5_000_000
        ),
        AccountModel(
            backgroundColor: UIColor(themeColor: .pink),
            tintColor: UIColor(themeColor: .white),
            name: "적금",
            hasSafeBox: false,
            accountBalance: 3_500_000,
            safeBoxBalance: 0
        ),
        AccountModel(
            backgroundColor: UIColor(themeColor: .blue),
            tintColor: UIColor(themeColor: .white),
            name: "예금",
            hasSafeBox: false,
            accountBalance: 10_000_000,
            safeBoxBalance: 0
        ),
        AccountModel(
            backgroundColor: UIColor(themeColor: .green),
            tintColor: UIColor(themeColor: .white),
            name: "저금통",
            hasSafeBox: false,
            accountBalance: 50_000,
            safeBoxBalance: 0
        ),
    ]
    
    // 뷰컨트롤러와 뷰모델의 데이터 사이의 연결고리
    var getTopAdData: [AccountTopAdModel] {
        return self.accountTopAdData
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
            return safeBox == true ? 200 : 105
        } else {
            // 그 외의 나머지 셀은 75
            return 75
        }
    }
    
    // custom footer view
    func viewForFooterInSection(at section: Int) -> UIView? {
        return section == 2 ? UIView() : nil
    }
    
}