//
//  AccountHeaderView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

class AccountHeaderView: UIView {

    //MARK: - UI 속성
    
    // 화면 제목
    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 내 계좌 버튼
    let myAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.myAccount.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    // 프로필 이미지
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        if UserDefaults.standard.userID == "user1" { iv.image = UIImage(named: "user1_profile_image.png") }
        if UserDefaults.standard.userID == "user2" { iv.image = UIImage(named: "user2_profile_image.png") }
        if UserDefaults.standard.userID == "user3" { iv.image = UIImage(named: "user3_profile_image.png") }
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        self.addSubview(self.tabTitleLabel)
        self.addSubview(self.myAccountButton)
        self.addSubview(self.profileImageView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 제목 레이블
        self.tabTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.left.equalToSuperview().offset(25)
        }
        
        // 내 계좌 버튼
        self.myAccountButton.snp.makeConstraints {
            $0.left.equalTo(self.tabTitleLabel.snp.right).offset(5)
            $0.centerY.equalTo(self.tabTitleLabel.snp.centerY)
            $0.height.equalTo(30)
            $0.width.equalTo(60)
        }
        
        // 프로필 이미지
        self.profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalTo(self.tabTitleLabel.snp.centerY)
            $0.right.equalToSuperview().offset(-25)
        }
    }
    
    //MARK: - 뷰컨트롤러에서 호출되는 메서드
    
    func setTitle(title: String) {
        self.tabTitleLabel.text = title
    }

}
