//
//  AccountTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit
import SnapKit

class AccountTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "AccountTableViewCell"
    
    //MARK: - 컨테이너 뷰 관련 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    //MARK: - 계좌 정보 관련 속성
    
    // 은행 로고
    private let bankLogoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "b.circle")
        view.tintColor = UIColor(themeColor: .white)
        return view
    }()
    
    // 계좌 이름
    private let accountNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 계좌 잔고
    private let accountBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 계좌 정보에 대한 스택뷰
    private lazy var accountStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.accountNameLabel, self.accountBalanceLabel])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    //MARK: - 버튼 관련 속성
    
    // 설정 버튼
    private let settingButton: UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.setImage(
            UIImage(
                systemName: "ellipsis",
                withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15, weight: .ultraLight))
            )?.withBaselineOffset(fromBottom: 0),
            for: .normal
        )
        return button
    }()
    
    // 카드 버튼
    private let cardButton: UIButton = {
        let button = UIButton()
        button.setTitle("카드", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    // 이체 버튼
    let transferButton: UIButton = {
        let button = UIButton()
        button.setTitle("이체", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 16
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
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "세이프박스"
        return label
    }()
    
    // 세이프박스 잔고
    private let safeBoxBalanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        // 컨테이너 뷰
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        // 설정 버튼
        self.containerView.addSubview(self.settingButton)
        self.settingButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(10)
        }
        
        // 은행 로고
        self.containerView.addSubview(self.bankLogoImage)
        self.bankLogoImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(self.settingButton.snp.bottom)
            $0.width.height.equalTo(35)
        }
        
        // 계좌 정보 스택뷰
        self.containerView.addSubview(self.accountStackView)
        self.accountStackView.snp.makeConstraints {
            $0.left.equalTo(self.bankLogoImage.snp.right).offset(8)
            $0.centerY.equalTo(self.bankLogoImage.snp.centerY)
            $0.height.equalTo(45)
        }
        
        // 카드/이체 버튼 스택뷰
        self.containerView.addSubview(self.buttonStackView)
        self.buttonStackView.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(105)
            $0.height.equalTo(32)
            $0.top.equalTo(self.accountStackView.snp.bottom).offset(10)
        }
        self.cardButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        self.transferButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
        }
        
        // 구분선
        self.containerView.addSubview(self.separatorLine)
        self.separatorLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(self.buttonStackView.snp.bottom).offset(20)
            $0.height.equalTo(0.2)
        }
        
        // 세이프박스 스택뷰
        self.containerView.addSubview(self.safeBoxStackView)
        self.safeBoxStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.bottom.equalToSuperview().offset(-20)
            $0.height.equalTo(20)
        }
    }

    //MARK: - 뷰컨트롤러에서 호출하는 메서드
    
    // 계좌 잔고로 표시할 금액 설정
    func setAccount(backgroundColor: UIColor, tintColor: UIColor,
                    accountName: String, accountNumber: String,
                    accountBalance: String, safeBoxBalance: String) {
        self.containerView.backgroundColor = backgroundColor
        
        self.settingButton.tintColor = tintColor
        self.cardButton.setTitleColor(tintColor, for: .normal)
        self.transferButton.setTitleColor(tintColor, for: .normal)
        
        self.accountNameLabel.textColor = tintColor
        self.accountBalanceLabel.textColor = tintColor
        self.safeBoxNameLabel.textColor = tintColor
        self.safeBoxBalanceLabel.textColor = tintColor
        
        self.accountNameLabel.text = accountName
        self.accountBalanceLabel.text = accountBalance
        self.safeBoxBalanceLabel.text = safeBoxBalance
    }
    
    // 계좌 영역이 클릭되었을 때 실행할 메서드
    func accountAreaTapped() {
        print("계좌 이용 내역 화면으로 이동합니다.")
    }
    
    // 세이프박스 영역이 클릭되었을 때 실행할 메서드
    func safeBoxAreaTapped() {
        print("세이프박스 화면으로 이동합니다.")
    }
    
}
