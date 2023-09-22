//
//  TransferInfoNavigationView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/20.
//

import UIKit
import SnapKit

protocol TransferInfoNavigationViewDelegate: AnyObject {
    func backButtonTapped()
    func cancelButtonTapped()
}

class TransferInfoNavigationView: UIView {

    //MARK: - UI 속성
    
    // 돌아가기 버튼
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(themeColor: .black)
        button.setImage(UIImage(systemName: "chevron.left")!, for: .normal)
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 사용자명 레이블
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // 계좌번호 레이블
    private let accountNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // 레이블에 대한 스택뷰
    private lazy var labelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.userNameLabel, self.accountNumberLabel])
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 0
        return sv
    }()
    
    // 취소 버튼
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.cancel.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        button.backgroundColor = UIColor(themeColor: .white)
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - 델리게이트 속성
    
    weak var delegate: TransferInfoNavigationViewDelegate?

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
        self.addSubview(self.backButton)
        self.addSubview(self.cancelButton)
        self.addSubview(self.labelStackView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 돌아가기 버튼
        self.backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.left.equalToSuperview().offset(0)
            $0.width.height.equalTo(50)
        }
        
        // 취소 버튼
        self.cancelButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo(50)
        }
        
        // 레이블 스택뷰
        self.labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.bottom.equalToSuperview().offset(0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(150)
        }
    }
    
    // 버튼이 눌러졌을 때 실행할 내용
    @objc private func buttonTapped(_ button: UIButton) {
        if button == self.backButton {
            self.delegate?.backButtonTapped()
        }
        else if button == self.cancelButton {
            self.delegate?.cancelButtonTapped()
        }
    }
    
    //MARK: - 뷰컨트롤러에서 호출되는 메서드
    
    func setupNavigationView(bankName: String, userName: String, userAccountNumber: String) {
        self.userNameLabel.text = userName
        self.accountNumberLabel.text = "\(bankName) \(userAccountNumber)"
    }
    
}
