//
//  AccountWithoutSafeBoxTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/06.
//

import UIKit
import SnapKit

class AccountWithoutSafeBoxTableViewCell: UITableViewCell {

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
        self.addSubview(self.containerView)
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
            $0.left.equalTo(self.bankLogoImage.snp.right).offset(5)
            $0.centerY.equalTo(self.bankLogoImage.snp.centerY)
            $0.height.equalTo(45)
        }
    }

    //MARK: - 뷰컨트롤러에서 호출하는 메서드
    
    // 계좌 잔고로 표시할 금액 설정
    func setAccount(backgroundColor: UIColor, tintColor: UIColor, name: String, account: String) {
        self.containerView.backgroundColor = backgroundColor
        
        self.settingButton.tintColor = tintColor
        
        self.accountNameLabel.textColor = tintColor
        self.accountBalanceLabel.textColor = tintColor
        
        self.accountNameLabel.text = name
        self.accountBalanceLabel.text = account
    }
    
    // 계좌 영역이 클릭되었을 때 실행할 메서드
    func accountAreaTapped() {
        print("계좌 이용 내역 화면으로 이동합니다.")
    }
    
}
