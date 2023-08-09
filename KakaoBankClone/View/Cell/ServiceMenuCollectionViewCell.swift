//
//  ServiceMenuBarCollectionViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/06.
//

import UIKit
import SnapKit

class ServiceMenuCollectionViewCell: UICollectionViewCell {
    
    //MARK: - 식별자
    
    static let identifier = "ServiceMenuCollectionViewCell"
    
    //MARK: - UI 속성
    
    // 메뉴 이름
    let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 메뉴 이름 아래의 막대
    let underBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .black)
        return view
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupServiceNameLabel()
        self.setupUnderBarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 메서드
    
    // 메뉴 이름 설정
    private func setupServiceNameLabel() {
        self.contentView.addSubview(self.serviceNameLabel)
        self.serviceNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
    // 메뉴 이름 아래의 막대 설정
    private func setupUnderBarView() {
        self.contentView.addSubview(self.underBarView)
        self.underBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(2)
            $0.width.equalTo(20)
        }
    }
    
}
