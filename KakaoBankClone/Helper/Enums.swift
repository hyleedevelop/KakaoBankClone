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
    case darkGray
    case pink
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
}

//MARK: - 셀 제목 옆에 붙는 배지 타입

enum BadgeType {
    case none
    case new
    case event
}

//MARK: - 이체 화면의 레이아웃 관련 설정값

enum TransferLayoutValues {
    static let topSafeAreaHeight: CGFloat = 59
    static let navigationViewHeight: CGFloat = 90
    static let headerMaxHeight: CGFloat = navigationViewHeight + 65
}


//MARK: - 상품/서비스 화면의 레이아웃 관련 설정값

enum ServiceLayoutValues {
    static let topSafeAreaHeight: CGFloat = 59
    static let menuCollectionViewHeight: CGFloat = 35
    static let headerMinHeight: CGFloat = 75
    static let headerMaxHeight: CGFloat = headerMinHeight + 55
}

//MARK: - 은행 종류

enum BankType: String {
    case woori = "우리은행"
    case nonghyup = "농협은행"
    case hana = "하나은행"
    case kookmin = "국민은행"
}
