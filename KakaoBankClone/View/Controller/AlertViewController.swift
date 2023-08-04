//
//  AlertViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class AlertViewController: UIViewController {

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
        
        // 좌측 상단에 위치한 타이틀 설정
        self.navigationItem.makeLeftSideTitle(
            title: NavigationBarTitle.alert.rawValue, color: UIColor.black
        )
        self.navigationItem.titleView?.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }

}
