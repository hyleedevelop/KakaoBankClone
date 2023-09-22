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
    
    // 체크마크 이미지
    private let checkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.circle")!
        view.tintColor = UIColor(themeColor: .black)
        view.backgroundColor = UIColor(themeColor: .yellow)
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    // 메세지 레이블
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(
            string: "\(self.viewModel.selectedReceiverName)님에게\n\(self.viewModel.amount.commaSeparatedWon)원 보냈어요"
        ).withLineSpacing(spacing: 2, alignment: .center)
        return label
    }()
    
    // 계좌 레이블
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "\(self.viewModel.selectedReceiverAccount)"
        return label
    }()
    
    // 취소 버튼
    private lazy var exportButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .black)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        button.setTitle("확인", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 광고뷰
    private let adView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .transparentBlack)
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
    }
    
    //MARK: - 내부 메서드

    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.view.addSubview(self.checkImage)
        self.view.addSubview(self.messageLabel)
        self.view.addSubview(self.accountLabel)
        self.view.addSubview(self.adView)
        self.view.addSubview(self.buttonStackView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 체크마크 이미지
        self.checkImage.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(90)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(60)
        }
        
        // 메세지 레이블
        self.messageLabel.snp.makeConstraints {
            $0.top.equalTo(self.checkImage.snp.bottom).offset(30)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(70)
        }
        
        // 계좌 레이블
        self.accountLabel.snp.makeConstraints {
            $0.top.equalTo(self.messageLabel.snp.bottom).offset(3)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(13)
        }
        
        // 광고뷰
        self.adView.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            $0.height.equalTo(80)
            $0.bottom.equalTo(self.buttonStackView.snp.top).offset(-40)
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
    }
    
    // 버튼이 눌러졌을 때 실행할 내용
    @objc private func buttonTapped(_ button: UIButton) {
        if button == self.confirmButton {
            // 탭바 화면으로 이동
//            let tabBarController = TabBarController()
//            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            let window = windowScene?.windows.first
//
//            window?.rootViewController = tabBarController
//            window?.makeKeyAndVisible()
            
            //self.navigationController?.popToRootViewController(animated: true)
            self.navigationController?.topViewController?.dismiss(animated: true)
        }
    }
    
}
