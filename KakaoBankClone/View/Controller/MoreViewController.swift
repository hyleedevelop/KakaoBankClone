//
//  MoreMenuViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class MoreViewController: UIViewController {

    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.setupView()
    }

    //MARK: - 메서드
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        // 커스텀 설정 적용
        self.navigationController?.applyCustomSettings(color: .white)
        self.navigationItem.titleView?.backgroundColor = UIColor(themeColor: .white)
        
        // 네비게이션 바 구성
        let title = self.navigationItem.makeTitle(
            title: NavigationBarTitle.account.rawValue,
            color: UIColor(themeColor: .black)
        )
        let button = self.navigationItem.makeSettingButton(
            title: "앱설정"
        )
        
        self.navigationItem.leftBarButtonItems = [title]
        self.navigationItem.rightBarButtonItems = [button]
    }
    
    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }

}
