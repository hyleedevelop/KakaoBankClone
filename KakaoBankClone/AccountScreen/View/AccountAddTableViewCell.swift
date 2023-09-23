//
//  AccountAddTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit
import SnapKit

class AccountAddTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "AccountAddTableViewCell"
    
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
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "+"
        return label
    }()
    
    // 간편 홈 버튼
    private let simpleHomeButton: UIButton = {
        let button = UIButton()
        button.setTitle("간편 홈", for: .normal)
        button.setTitleColor(UIColor(themeColor: .darkGray), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return button
    }()
    
    // 얇은 세로 뷰
    private let thinVerticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .darkGray)
        view.alpha = 0.3
        return view
    }()
    
    // 화면 편집 버튼
    private let editScreenButton: UIButton = {
        let button = UIButton()
        button.setTitle("화면 편집", for: .normal)
        button.setTitleColor(UIColor(themeColor: .darkGray), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return button
    }()
    
    // 메뉴 스택뷰
    private lazy var menuStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.simpleHomeButton, self.thinVerticalView, self.editScreenButton])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 10
        return sv
    }()
    
    //MARK: - 생성자
    
    // TableViewCell 생성자 셋팅 (1)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
 
        self.setupSubview()
        self.setupAutoLayout()
    }
    
    // TableViewCell 생성자 셋팅 (2)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 메서드
    
    // 하위뷰 설정
    private func setupSubview() {
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.plusLabel)
        self.contentView.addSubview(self.menuStackView)
    }
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        // 컨테이너 뷰 설정
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(5)
            $0.height.equalTo(60)
        }
        
        // + 레이블
        self.plusLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        // 스택뷰 설정
        self.menuStackView.snp.makeConstraints {
            $0.top.equalTo(self.containerView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.45)
            $0.height.equalTo(13)
        }
        
        // 얇은 세로 뷰 설정
        self.thinVerticalView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(1)
            $0.bottom.equalToSuperview().offset(-1)
            $0.width.equalTo(1)
        }
    }
    
}
