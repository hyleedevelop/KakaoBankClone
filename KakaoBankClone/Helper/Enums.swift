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
}

//MARK: - 셀 제목 옆에 붙는 배지 타입

enum BadgeType {
    case none
    case new
    case event
}
