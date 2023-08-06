//
//  ServiceMenuBarCollectionViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/06.
//

import UIKit
import SnapKit

class ServiceMenuBarCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI 속성
    
    // 서비스 이름
    let serviceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 메서드
    
    private func setupAutoLayout() {
        // 서비스 이름
        self.addSubview(self.serviceNameLabel)
        self.serviceNameLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(5)
            $0.bottom.right.equalToSuperview().offset(-5)
        }
    }
    
}
