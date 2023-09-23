//
//  TransferCompleteViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/23.
//

import UIKit
import SnapKit

class TransferCompleteViewController: UIViewController {

    //MARK: - UI 속성
    
    // 체크마크 컨테이너 뷰
    private let checkContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .yellow)
        view.layer.cornerRadius = 27.5
        view.clipsToBounds = true
        return view
    }()
    
    // 체크마크 이미지
    private let checkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark")!
        view.tintColor = UIColor(themeColor: .black)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    // 메세지 레이블
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        let text = "\(self.viewModel.selectedReceiverName)님에게\n\(self.viewModel.amount.commaSeparatedWon)원 보냈어요"
        let attributedText = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "\(self.viewModel.amount.commaSeparatedWon)원")
        attributedText.addAttribute(.foregroundColor, value: UIColor(themeColor: .darkBlue), range: range)
        label.attributedText = attributedText.withLineSpacing(spacing: 2, alignment: .center)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // 계좌 레이블
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "\(self.viewModel.selectedReceiverBankName.dropLast(2)) \(self.viewModel.selectedReceiverAccount)  >"
        return label
    }()
    
    // 메모입력 버튼
    private let memoButton: UIButton = {
        let button = UIButton()
        button.setTitle("💬 메모입력..", for: .normal)
        button.setTitleColor(UIColor(themeColor: .darkGray), for: .normal)
        button.backgroundColor = UIColor(themeColor: .lightGray)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
        button.layer.cornerRadius = 17.5
        button.clipsToBounds = true
        return button
    }()
    
    // 공유하기 버튼
    private lazy var exportButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .navy)
        button.setImage(UIImage(systemName: "square.and.arrow.up")!, for: .normal)
        button.tintColor = UIColor(themeColor: .white)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 이체하기 버튼
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .yellow)
        button.setTitleColor(UIColor(themeColor: .black), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .light)
        button.setTitle("확인", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 광고 컨테이너뷰
    private let adView: TransferCompleteAdView = {
        let view = TransferCompleteAdView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // 버튼 스택뷰
    private lazy var buttonStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.exportButton, self.confirmButton])
        sv.axis = .horizontal
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 10
        return sv
    }()
    
    //MARK: - 뷰모델의 인스턴스 및 생성자
    
    private var viewModel: TransferCompleteViewModel
    
    init(viewModel: TransferCompleteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.addSubview()
        self.setupLayout()
        
        self.adView.setupUI(
            image: UIImage(named: "krw-money")!,
            title: "카엘라 비건 달맞이꽃종자유",
            subtitle: "최대 60%에 구매하기!"
        )
    }
    
    //MARK: - 내부 메서드

    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.view.addSubview(self.checkContainerView)
        self.checkContainerView.addSubview(self.checkImage)
        self.view.addSubview(self.messageLabel)
        self.view.addSubview(self.accountLabel)
        self.view.addSubview(self.memoButton)
        self.view.addSubview(self.adView)
        self.view.addSubview(self.buttonStackView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 체크 컨테이너 뷰
        self.checkContainerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(90)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(55)
        }
        
        // 체크 이미지
        self.checkImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        
        // 메세지 레이블
        self.messageLabel.snp.makeConstraints {
            $0.top.equalTo(self.checkContainerView.snp.bottom).offset(30)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        
        // 계좌 레이블
        self.accountLabel.snp.makeConstraints {
            $0.top.equalTo(self.messageLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(13)
        }
        
        // 메모 버튼
        self.memoButton.snp.makeConstraints {
            $0.top.equalTo(self.accountLabel.snp.bottom).offset(65)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.equalTo(105)
            $0.height.equalTo(35)
        }
        
        // 버튼 스택뷰
        self.buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.snp.bottom).offset(-35)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            $0.height.equalTo(60)
        }
        
        // 내보내기 버튼
        self.exportButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-5).multipliedBy(0.25)
            $0.top.bottom.equalToSuperview()
        }
        
        // 확인 버튼
        self.confirmButton.snp.makeConstraints {
            $0.width.equalToSuperview().offset(-5).multipliedBy(0.75)
            $0.top.bottom.equalToSuperview()
        }
        
        // 광고뷰
        self.adView.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            $0.height.equalTo(80)
            $0.bottom.equalTo(self.buttonStackView.snp.top).offset(-40)
        }
    }
    
    // 버튼이 눌러졌을 때 실행할 내용
    @objc private func buttonTapped(_ button: UIButton) {
        if button == self.confirmButton {
            self.navigationController?.topViewController?.dismiss(animated: true)
        }
    }
    
}
