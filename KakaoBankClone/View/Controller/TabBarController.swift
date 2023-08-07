//
//  TabBarController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabBar()
    }
    
    //MARK: - Methods
    
    // 탭바 설정
    private func setupTabBar() {
        // iOS 15 업데이트 이후 TabBar, NavigationBar가 제대로 보이지 않는 문제 해결
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        self.tabBar.tintColor = UIColor.black
        self.tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        self.tabBar.layer.borderWidth = 0.3
        self.tabBar.clipsToBounds = true
        
        // 계좌 탭 (홈)
        let vc1 = UINavigationController(rootViewController: AccountViewController())
        vc1.tabBarItem.image = UIImage(
            systemName: "person.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17))
        )?.withBaselineOffset(fromBottom: 14)
        
        // 서비스 탭
        let vc2 = UINavigationController(rootViewController: ServiceViewController())
        vc2.tabBarItem.image = UIImage(
            systemName: "square.grid.2x2.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17))
        )?.withBaselineOffset(fromBottom: 14)
        
        // 알림 탭
        let vc3 = UINavigationController(rootViewController: AlertViewController())
        vc3.tabBarItem.image = UIImage(
            systemName: "bell.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17))
        )?.withBaselineOffset(fromBottom: 14)
        
        // 서비스 탭
        let vc4 = UINavigationController(rootViewController: MoreViewController())
        vc4.tabBarItem.image = UIImage(
            systemName: "ellipsis",
            withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17))
        )?.withBaselineOffset(fromBottom: 7)
        
        self.viewControllers = [vc1, vc2, vc3, vc4]
        
        // 앱을 처음 실행했을 때 화면에 보여줄 탭
        self.selectedIndex = 0
    }

    // 탭 바의 높이를 조절
    private func adjustTabBarHeight(tabBar: UITabBar, height: CGFloat) {
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = height - tabBar.frame.height
    }

    
    
}
