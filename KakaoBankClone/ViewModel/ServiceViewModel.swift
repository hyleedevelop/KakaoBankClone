//
//  ServiceMenuViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class ServiceViewModel {
    
    //MARK: - 데이터
    
    let topAdData: [ServiceTopAdModel] = [
        ServiceTopAdModel(
            backgroundColor: UIColor(themeColor: .blue),
            title: "광고1",
            subtitle: "광고1 입니다.",
            image: UIImage(systemName: "star")!
        ),
        ServiceTopAdModel(
            backgroundColor: UIColor(themeColor: .green),
            title: "광고2",
            subtitle: "광고2 입니다.",
            image: UIImage(systemName: "star")!
        ),
        ServiceTopAdModel(
            backgroundColor: UIColor(themeColor: .yellow),
            title: "광고3",
            subtitle: "광고3 입니다.",
            image: UIImage(systemName: "star")!
        ),
    ]
    
    let serviceListData: [[ServiceListModel]] = [[
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "입출금통장",
            subtitle: "까다로운 계좌개설도 손쉽게",
            hasInterest: true,
            interest: "연 0.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "모임통장",
            subtitle: "함께쓰고 같이봐요",
            hasInterest: true,
            interest: "연 0.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "세이프박스",
            subtitle: "여유자금을 따로 보관하세요",
            hasInterest: true,
            interest: "연 2.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "저금통",
            subtitle: "매일매일 조금씩 쌓여요",
            hasInterest: true,
            interest: "연 10.00%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "정기예금",
            subtitle: "실시간 이자가 쌓여요",
            hasInterest: true,
            interest: "연 3.50%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "자유적금",
            subtitle: "매일/매주/매월 자유롭게",
            hasInterest: true,
            interest: "연 4.00%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "기록통장",
            subtitle: "최애적금으로 세상처음 돈버는 덕질",
            hasInterest: true,
            interest: "연 2.00%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "26주적금",
            subtitle: "캐릭터와 함께 즐거운 도전",
            hasInterest: true,
            interest: "연 7.00%"
        )
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "프렌즈 체크카드",
            subtitle: "쓸 때마다 캐시백, 주말엔 2배",
            hasInterest: false,
            interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "제휴 신용카드",
            subtitle: "신청은 간편하게 혜택은 다양하게",
            hasInterest: false,
            interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),
            title: "카드 청구금액 알림",
            subtitle: "결제일 별로 청구금액과 계좌 잔액을 한눈에",
            hasInterest: false,
            interest: nil
        ),
    ]]
    
    //MARK: - 테이블뷰 관련
    
    // section의 개수
    let numberOfSections: Int = 3
    
    // section당 row의 개수
    func numberOfRowsInSection(at section: Int) -> Int {
        return section == 0 ? 1 : self.serviceListData[section-1].count
    }
    
    // header 높이
    let headerHeight: CGFloat = 40
    
    // footer 높이
    func footerHeight(at section: Int) -> CGFloat {
        return 40
    }
    
    // cell 높이
    func cellHeight(at section: Int) -> CGFloat {
        return section == 0 ? 310 : 90
    }
    
    // custom footer view
    func viewForFooterInSection(at section: Int) -> UIView? {
        return UIView()
    }
    
}
