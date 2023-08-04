//
//  Enums.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit

//MARK: - 테마 색상

enum ThemeColor: Int {
    case black = 0
    case white
    case lightGray
    case yellow
}

//MARK: - 셀 식별자

enum CellIdentifier: String {
    case account = "AccountCell"
    case accountTopAd = "AccountTopAdCell"
    case accountAdd = "AccountAddTableViewCell"
    case serviceMenu = "ServiceMenuCell"
    case alert = "AlertCell"
    case moreMenu = "MoreMenuCell"
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
