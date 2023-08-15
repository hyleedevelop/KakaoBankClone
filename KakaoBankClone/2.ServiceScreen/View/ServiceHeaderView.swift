//
//  ServiceTableHeaderView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/09.
//

import UIKit
import SnapKit

class ServiceHeaderView: UIView {
    
    //MARK: - UI 속성
    
    // 화면 제목
    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = NavigationBarTitle.serviceMenu.rawValue
        return label
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupTabTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드

    // 뷰 설정
    private func setupView() {
        self.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 화면 상단 제목 설정
    private func setupTabTitleLabel() {
        self.addSubview(self.tabTitleLabel)
        
        self.tabTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.left.equalToSuperview().offset(25)
        }
    }
}


