//
//  Enums.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit

//MARK: - 데이터 모델

enum ServiceCellModel {
    case topAdCollectionView(model: [ServiceTopAdModel])
    case listTableView(model: [[ServiceListModel]])
}

//MARK: - 상품/서비스 화면의 컬렉션뷰

enum ServiceCollectionView {
    case menu
    case topAd
    case footerAd
}

//MARK: - 테마 색상

enum ThemeColor {
    case transparentBlack
    case black
    case white
    case lightGray
    case faintGray
    case darkGray
    case pink
    case red
    case yellow
    case green
    case blue
}

//MARK: - 네비게이션 바 제목

enum NavigationBarTitle: String {
    case account = "홍길동"
    case serviceMenu = "상품/서비스"
    case alert = "알림"
    case transfer = "이체"
}

//MARK: - 버튼 제목

enum ButtonTitle: String {
    case myAccount = "내 계좌"
    case appSetting = "앱설정"
    case close = "닫기"
    case login = "로그인"
    case cancel = "취소"
    case next = "다음"
    case enterAccount = "+ 계좌번호 직접입력"
}

//MARK: - 셀 제목 옆에 붙는 배지 타입

enum BadgeType: String {
    case none = ""
    case new = "NEW"
    case event = "EVENT"
    case up = "UP"
}

//MARK: - 이체 화면의 레이아웃 관련 설정값

enum TransferLayoutValues {
    static let topSafeAreaHeight: CGFloat = 59
    static let receiverListNavigationViewHeight: CGFloat = 90
    static let transferInfoNavigatoinViewHiehgt: CGFloat = 110
    static let headerMaxHeight: CGFloat = receiverListNavigationViewHeight + 65
}


//MARK: - 상품/서비스 화면의 레이아웃 관련 설정값

enum ServiceLayoutValues {
    static let topSafeAreaHeight: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 59
    static let menuCollectionViewHeight: CGFloat = 38
    static let headerMinHeight: CGFloat = 75
    static let headerMaxHeight: CGFloat = headerMinHeight + 57
    static let headerChangeHeight: CGFloat = headerMaxHeight - headerMinHeight
    static let totalMinHeight: CGFloat = topSafeAreaHeight + headerMinHeight + menuCollectionViewHeight
    static let totalMaxHeight: CGFloat = topSafeAreaHeight + headerMaxHeight + menuCollectionViewHeight
}

//MARK: - 은행 종류

enum BankType: String {
    case kakao = "카카오뱅크"
    case woori = "우리은행"
    case nonghyup = "농협은행"
    case kookmin = "국민은행"
    case hana = "하나은행"
    case shinhan = "신한은행"
}

//MARK: - 사용자 계정

enum UserID: String, CaseIterable {
    case user1 = "user1"
    case user2 = "user2"
    case user3 = "user3"
}

enum UserPassword: String {
    case user1 = "user1user1"
    case user2 = "user2user2"
    case user3 = "user3user3"
}
