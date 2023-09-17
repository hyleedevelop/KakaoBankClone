//
//  ConfirmModalView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/23.
//

import UIKit
import SnapKit

protocol TransferConfirmModalViewDelegate: AnyObject {
    func dismissButtonTapped()
    func transferButtonTapped()
}

class TransferConfirmModalView: UIView {

    //MARK: - UI 속성
    
    // 은행 로고
    private let bankLogoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Kakao_Bank_of_Korea_Logo")
        //view.backgroundColor = UIColor(themeColor: .blue)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    // 메세지 레이블
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // 계좌 레이블
    private let accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // 메세지 스택뷰
    private lazy var messageStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.bankLogoImage, self.messageLabel, self.accountLabel])
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .equalSpacing
        sv.spacing = 0
        return sv
    }()
    
    // 취소 버튼
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.setTitleColor(UIColor(themeColor: .black), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.setTitle("취소", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 이체하기 버튼
    private lazy var transferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .yellow)
        button.setTitleColor(UIColor(themeColor: .black), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.setTitle("이체하기", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 버튼 스택뷰
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.cancelButton, self.transferButton])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    //MARK: - 델리게이트 속성
    
    weak var delegate: TransferConfirmModalViewDelegate?

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
        self.addSubview(self.buttonStackView)
        self.addSubview(self.messageStackView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 버튼 스택뷰
        self.buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.snp.bottom).offset(-35)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(60)
        }
        
        self.cancelButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-5).multipliedBy(0.4)
            $0.top.bottom.equalToSuperview()
        }
        
        self.transferButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-5).multipliedBy(0.6)
            $0.top.bottom.equalToSuperview()
        }
        
        // 메세지 스택뷰
        self.messageStackView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(50)
            $0.bottom.equalTo(self.buttonStackView.snp.top).offset(-45)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
        }
        
        self.bankLogoImage.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
    }
    
    // 버튼이 눌러졌을 때 실행할 내용
    @objc private func buttonTapped(_ button: UIButton) {
        if button == self.transferButton {
            self.delegate?.transferButtonTapped()
        }
        if button == self.cancelButton {
            self.delegate?.dismissButtonTapped()
        }
    }
    
    //MARK: - 뷰컨트롤러에서 호출하는 메서드
    
    func setupMessage(selectedUserName: String, selectedUserAccount: String, currentInputAmount: Int) {
        self.messageLabel.attributedText = NSAttributedString(
            string: "\(selectedUserName)님에게 \(currentInputAmount.commaSeparatedWon)원\n이체하시겠습니까?"
        ).withLineSpacing(5)
        
        self.accountLabel.text = "받는계좌: \(BankType.kakao.rawValue) \(selectedUserAccount)"
    }
    
}
