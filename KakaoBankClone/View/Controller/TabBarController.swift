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
        // iOS 15 업데이트 이후 TabBar, NavigationBar가 보이지 않는 문제 해결
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor(named: "IBColor")
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        self.tabBar.tintColor = .label
        
        // 계좌 탭 (홈)
        let vc1 = UINavigationController(rootViewController: AccountViewController())
        //vc1.tabBarItem.title = "계좌"
        vc1.tabBarItem.image = UIImage(systemName: "person.fill")
        
        // 서비스 탭
        let vc2 = UINavigationController(rootViewController: ServiceMenuViewController())
        vc2.tabBarItem.image = UIImage(systemName: "square.grid.2x2.fill")
        
        // 알림 탭
        let vc3 = UINavigationController(rootViewController: AlertViewController())
        vc3.tabBarItem.image = UIImage(systemName: "bell.fill")
        
        // 서비스 탭
        let vc4 = UINavigationController(rootViewController: MoreMenuViewController())
        vc4.tabBarItem.image = UIImage(systemName: "ellipsis")
        
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
