//
//  AccountTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit
import SnapKit

class AccountTableViewCell: UITableViewCell {

    //MARK: - 컨테이너 뷰 관련 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    //MARK: - 계좌 정보 관련 속성
    
    // 계좌 이름
    private let accountNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 계좌 잔고
    private let accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - 버튼 관련 속성
    
    // 설정 버튼
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    // 카드 버튼
    private let cardButton: UIButton = {
        let button = UIButton()
        button.setTitle("카드", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .lightGray)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    // 이체 버튼
    private let transferButton: UIButton = {
        let button = UIButton()
        button.setTitle("이체", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .lightGray)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    // 카드/이체 버튼에 대한 스택뷰
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.cardButton, self.transferButton])
        sv.axis = .horizontal
        sv.alignment = .trailing
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()
    
    //MARK: - 구분선 관련 속성
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    //MARK: - 세이프박스 관련 속성
    
    // 세이프박스 이름
    private let safeBoxNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "세이프박스"
        return label
    }()
    
    // 세이프박스 잔고
    private let safeBoxBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 세이프박스에 대한 스택뷰
    private lazy var safeBoxStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.safeBoxNameLabel, self.safeBoxBalanceLabel])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalCentering
        sv.spacing = 0
        return sv
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
    
    //MARK: - 내부 메서드
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        // 컨테이너 뷰 설정
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        // 계좌 정보 설정
        self.containerView.addSubview(self.accountBalanceLabel)
        self.accountBalanceLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(50)
        }
        
        // 세이프박스 스택뷰 설정
        self.containerView.addSubview(self.safeBoxStackView)
        self.safeBoxStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(20)
        }
        
        // 구분선 설정
        self.containerView.addSubview(self.separatorLine)
        self.separatorLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(self.safeBoxStackView.snp.top).offset(-15)
            $0.height.equalTo(0.5)
        }
        
        // 카드/이체 버튼 설정
        self.containerView.addSubview(self.buttonStackView)
        self.buttonStackView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(105)
            $0.height.equalTo(30)
            $0.bottom.equalTo(self.separatorLine.snp.top).offset(-15)
        }
    }

    //MARK: - 뷰컨트롤러에서 호출하는 메서드
    
    // 컨테이너 뷰 색상 설정
    func setContainerViewColor(color: UIColor) {
        self.containerView.backgroundColor = color
    }
    
    // 계좌 잔고로 표시할 금액 설정
    func setBalance(account: Int, safeBox: Int) {
        self.accountBalanceLabel.text = "\(account)원"
        self.safeBoxBalanceLabel.text = "\(safeBox)원"
    }
    
}