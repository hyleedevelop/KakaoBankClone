//
//  NavigationBar.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import SnapKit

//MARK: - UINavigationController

extension UINavigationController {
    
    // 커스텀 설정
    func applyCustomSettings(color: ThemeColor) {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.shadowColor = UIColor.clear  // 경계선
        standardAppearance.backgroundColor = UIColor(themeColor: color)
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.shadowColor = UIColor.clear  // 경계선
        scrollEdgeAppearance.backgroundColor = UIColor(themeColor: color)
        
        self.navigationBar.standardAppearance = standardAppearance
        self.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.isTranslucent = true
        self.navigationBar.isHidden = false
        self.navigationBar.backgroundColor = UIColor.white
        self.additionalSafeAreaInsets = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 10)
        //self.additionalSafeAreaInsets.top = 20
        //self.additionalSafeAreaInsets.bottom = 20
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
}

//MARK: - UINavigationItem

extension UINavigationItem {
 
    // 화면 왼쪽에 커스텀 타이틀 생성
    func makeLeftSideTitle(title: String, color: UIColor) {
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    func makeTitle(title: String, color: UIColor) -> UIBarButtonItem {
        let label = UILabel()
        label.textColor = color
        label.text = title
        //label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        let barButtonItem = UIBarButtonItem(customView: label)
        
        return barButtonItem
    }
    
    func makeSettingButton(title: String) -> UIBarButtonItem {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .lightGray)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(60)
        }
        
        return barButtonItem
    }
    
    func makeProfileImage(image: UIImage) -> UIBarButtonItem {
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        let barButtonItem = UIBarButtonItem(customView: imageView)
        barButtonItem.customView?.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        
        return barButtonItem
    }
    
}

//MARK: - CALayer

extension CALayer {
    
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
    
}
