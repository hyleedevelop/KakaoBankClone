//
//  MoreHeaderView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

class MoreHeaderView: UIView {

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
    
    // 앱설정 버튼
    let settingButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.appSetting.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    // disclosure 이미지
    let chevronImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = UIColor(themeColor: .darkGray)
        iv.image = UIImage(systemName: "chevron.right")
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
    
    // 화면 상단 제목 설정
    private func addSubview() {
        self.addSubview(self.tabTitleLabel)
        self.addSubview(self.chevronImageView)
        self.addSubview(self.settingButton)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 제목 레이블
        self.tabTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.left.equalToSuperview().offset(24)
        }
        
        // chevron 이미지
        self.chevronImageView.snp.makeConstraints {
            $0.left.equalTo(self.tabTitleLabel.snp.right).offset(5)
            $0.width.equalTo(10)
            $0.height.equalTo(15)
            $0.centerY.equalTo(self.tabTitleLabel.snp.centerY)
        }
        
        // 앱설정 버튼
        self.settingButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalTo(self.tabTitleLabel.snp.centerY)
            $0.height.equalTo(30)
            $0.width.equalTo(60)
        }
    }
    
    //MARK: - 뷰컨트롤러에서 호출되는 메서드
    
    func setTitle(title: String) {
        self.tabTitleLabel.text = title
    }

}
