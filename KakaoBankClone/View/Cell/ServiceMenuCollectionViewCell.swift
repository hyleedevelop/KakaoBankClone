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
        label.textColor = UIColor(white: 0.5, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.layer.borderColor = UIColor.brown.cgColor
        //self.layer.borderWidth = 0
        
        self.setupServiceNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 메뉴 이름 설정
    private func setupServiceNameLabel() {
        self.contentView.addSubview(self.serviceNameLabel)
        self.serviceNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
}
