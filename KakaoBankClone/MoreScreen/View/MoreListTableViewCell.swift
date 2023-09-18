//
//  MoreTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

class MoreListTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "MoreListTableViewCell"
    
    //MARK: - UI 속성
    
    // 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 뱃지 버튼
    let badgeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(UIColor(themeColor: .white), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8, weight: .bold)
        button.backgroundColor = UIColor(themeColor: .red)
        button.layer.cornerRadius = 7.5
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    //MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
        self.addSubview()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 뷰 설정
    private func setupView() {
        self.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.badgeButton)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 제목 레이블
        self.titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(-0)
        }
        
        // 뱃지 버튼
        self.badgeButton.snp.makeConstraints {
            $0.left.equalTo(self.titleLabel.snp.right).offset(10)
            $0.height.equalTo(15)
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 뷰컨트롤러에서 값을 받아 UI 설정
    func setCellUI(title: String, badge: BadgeType) {
        self.titleLabel.text = title
        
        if badge.rawValue.isEmpty {
            self.badgeButton.isHidden = true
        } else {
            self.badgeButton.isHidden = false
            self.badgeButton.setTitle(badge.rawValue, for: .normal)
        }
    }
    
}
