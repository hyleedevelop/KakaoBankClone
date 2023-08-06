//
//  AccountAddTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit
import SnapKit

class AccountAddTableViewCell: UITableViewCell {

    //MARK: - UI 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(themeColor: .transparentBlack)
        return view
    }()
    
    // 제목
    private let plusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "+"
        return label
    }()
    
    //MARK: - 생성자
    
    // TableViewCell 생성자 셋팅 (1)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
 
        self.setupAutoLayout()
    }
    
    // TableViewCell 생성자 셋팅 (2)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 메서드
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        // 컨테이너 뷰 설정
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        // 스택뷰 설정
        self.containerView.addSubview(self.plusLabel)
        self.plusLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}
