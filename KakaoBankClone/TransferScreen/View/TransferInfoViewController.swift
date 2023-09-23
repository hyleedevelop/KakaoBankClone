//
//  SendMoneyViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/20.
//

import UIKit
import SnapKit

final class TransferInfoViewController: UIViewController {
    
    //MARK: - UI 속성
    
    // 화면 최상단의 네비게이션 뷰
    internal let navigationView: TransferInfoNavigationView = {
        let view = TransferInfoNavigationView()
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 0
        return view
    }()
    
    // 레이블 컨테이너 뷰
    internal let amountStatusContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .white)
        return view
    }()
    
    // 금액 레이블
    internal let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .faintGray)
        label.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "보낼금액"
        return label
    }()
    
    // 현황 설명 레이블
    internal let currentStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    // 내 계좌 선택 버튼
    internal let myAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        return button
    }()
    
    // 내 계좌 선택 레이블
    internal lazy var myAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "\(self.viewModel.accountName)(\(self.viewModel.accountNumber.suffix(4))): " +
        "\(self.viewModel.currentBalance.commaSeparatedWon)원"
        return label
    }()
    
    // 받는 분에게 표기 컨테이너 뷰
    internal let yourTransactionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .white)
        view.layer.borderColor = UIColor(themeColor: .transparentBlack).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.alpha = 0
        return view
    }()
    
    // 받는 분에게 표기 레이블
    internal let yourTransactionNicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "받는 분에게 표기"
        return label
    }()
    
    // 받는 분에게 표기 텍스트필드
    internal lazy var yourTransactionNicknameTextfield: UITextField = {
        let tf = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .light),
            .strokeColor: UIColor(themeColor: .black)
        ]
        tf.attributedPlaceholder = NSAttributedString(string: self.viewModel.userName, attributes: attributes)
        tf.font = UIFont.systemFont(ofSize: 14, weight: .light)
        tf.textColor = UIColor(themeColor: .black)
        tf.textAlignment = .right
        return tf
    }()
    
    // 나에게 표기 컨테이너 뷰
    internal let myTransactionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .white)
        view.layer.borderColor = UIColor(themeColor: .transparentBlack).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.alpha = 0
        return view
    }()
    
    // 나에게 표기 레이블
    internal let myTransactionNicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "나에게 표기"
        return label
    }()
    
    // 나에게 표기 텍스트필드
    internal let myTransactionNicknameTextfield: UITextField = {
        let tf = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .light)]
        tf.attributedPlaceholder = NSAttributedString(string: "미입력시 수취인명", attributes: attributes)
        tf.textAlignment = .right
        return tf
    }()
    
    // 추가이체 레이블
    internal let additionalTransferLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "+ 추가이체"
        label.alpha = 0
        return label
    }()
    
    // 더보기 레이블
    internal let seeMoreLabel: UILabel = {
        let label = UILabel()
        let text = "더보기"
        let attributedText = NSMutableAttributedString(string: text)
        let underlineRange = (text as NSString).range(of: text)
        attributedText.addAttribute(
            NSAttributedString.Key.underlineStyle, 
            value: NSUnderlineStyle.single.rawValue,
            range: underlineRange
        )
        label.attributedText = attributedText
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.alpha = 0
        return label
    }()
    
    // 금액을 추가 버튼 생성: createAmountAddButton() 메서드 참고
    internal let addAmountStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 7
        return sv
    }()
    
    // 금액 버튼 스택뷰: createKeypadButton() 메서드 참고
    internal let keypadStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 0
        return sv
    }()
    
    // 다음 버튼
    internal lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.next.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .light)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.isUserInteractionEnabled = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(self.nextButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 이체 확인 모달뷰
    internal let transferConfirmModalView: TransferConfirmModalView = {
        let view = TransferConfirmModalView()
        view.backgroundColor = UIColor(themeColor: .white)
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = false
        return view
    }()
    
    // 모달뷰가 나타났을 때 나머지 배경을 어둡게 하는 디밍뷰
    internal let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .black)
        view.alpha = 0.0
        return view
    }()
    
    // 로딩 표시
    internal let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.stopAnimating()
        ai.style = .large
        return ai
    }()
    
    //MARK: - 뷰모델의 인스턴스 및 생성자
    
    internal var viewModel: TransferInfoViewModel
    
    init(viewModel: TransferInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 기타 속성
    
    // 보낼금액(원)
    internal var currentInputAmount: Int = 0 {
        didSet {
            // 보낼금액 값이 변할 때마다 UI가 변경 메서드 실행
            self.changeUI()
        }
    }
    
    // 다음 버튼을 최초로 탭 하는지에 대한 여부
    internal var nextButtonTapCount: Int = 0
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        self.createKeypadButtons()
        self.createAmountAddButtons()
        
        self.addSubview()
        self.setupLayout()
        self.setupDelegate()
        
        self.navigationView.setupNavigationView(
            bankName: self.viewModel.selectedReceiverBankName,
            userName: self.viewModel.selectedReceiverName,
            userAccountNumber: self.viewModel.selectedReceiverAccount
        )
    }
    
    //MARK: - UI 생성 메서드
    
    // 보낼금액을 입력하는 키패드 버튼 생성
    private func createKeypadButtons() {
        // 행의 개수
        let rowCount = 4
        // 열의 개수
        let columnCount = 3
        // 수평 스택뷰에서의 요소간 간격
        let horizontalSpacing: CGFloat = 20
        // 버튼 인덱스
        var buttonIndex = 0
        
        (0..<rowCount).forEach { _ in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = horizontalSpacing
            
            (0..<columnCount).forEach { _ in
                let button = UIButton(type: .system)
                if buttonIndex == rowCount*columnCount - 1 {
                    button.setImage(UIImage(systemName: "arrow.left")!, for: .normal)
                    button.tintColor = UIColor(themeColor: .black)
                } else {
                    button.setTitle(self.viewModel.keypadButtonTitles[buttonIndex], for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
                    button.setTitleColor(UIColor(themeColor: .black), for: .normal)
                }
                button.tag = buttonIndex  // 0 ~ 11
                button.addTarget(self, action: #selector(self.keypadButtonTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
                
                buttonIndex += 1
            }
            
            self.keypadStackView.addArrangedSubview(rowStackView)
        }
    }
    
    // 보낼금액을 추가할 수 있는 버튼 생성
    private func createAmountAddButtons() {
        // 열의 개수
        let columnCount = 4
        
        for index in (0..<columnCount) {
            let button = UIButton(type: .system)
            button.setTitle(self.viewModel.addAmountButtonTitles[index], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            button.setTitleColor(UIColor(themeColor: .darkGray), for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor(themeColor: .darkGray).cgColor
            button.layer.cornerRadius = 7
            button.clipsToBounds = false
            button.tag = index + 20  // 20 ~ 23
            button.addTarget(self, action: #selector(self.addAmountButtonTapped(_:)), for: .touchUpInside)
            
            self.addAmountStackView.addArrangedSubview(button)
        }
    }
    
    //MARK: - 기본 UI 설정 메서드
    
    // 뷰 설정
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.view.addSubview(self.navigationView)
        self.view.addSubview(self.nextButton)
        self.view.addSubview(self.keypadStackView)
        self.view.addSubview(self.addAmountStackView)
        self.view.addSubview(self.myAccountButton)
        self.view.addSubview(self.myAccountLabel)
        self.view.addSubview(self.amountStatusContainerView)
        self.view.addSubview(self.activityIndicator)
        
        self.amountStatusContainerView.addSubview(self.amountLabel)
        self.amountStatusContainerView.addSubview(self.currentStatusLabel)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 네비게이션 뷰
        self.navigationView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(TransferLayoutValues.transferInfoNavigatoinViewHiehgt)
        }
        
        // 다음 버튼
        self.nextButton.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        // 금액 키패드 버튼 스택뷰
        self.keypadStackView.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            $0.bottom.equalTo(self.nextButton.snp.top).offset(-15)
            $0.height.equalTo(240)
        }
        
        // 금액 추가 버튼 스택뷰
        self.addAmountStackView.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            $0.bottom.equalTo(self.self.keypadStackView.snp.top).offset(-12)
            $0.height.equalTo(30)
        }
        
        // 내 계좌 선택 버튼
        self.myAccountButton.snp.makeConstraints {
            $0.left.right.equalTo(self.addAmountStackView)
            $0.bottom.equalTo(self.addAmountStackView.snp.top).offset(-12)
            $0.height.equalTo(44)
        }
        
        // 내 계좌 선택 버튼
        self.myAccountLabel.snp.makeConstraints {
            $0.left.equalTo(self.myAccountButton.snp.left).offset(15)
            $0.centerY.equalTo(self.myAccountButton.snp.centerY)
            $0.width.equalTo(self.myAccountButton.snp.width).multipliedBy(0.8)
        }
        
        // 레이블 컨테이너뷰
        self.amountStatusContainerView.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.top.equalTo(self.navigationView.snp.bottom)
            $0.bottom.equalTo(self.myAccountButton.snp.top)
        }
        
        // 보낼금액 레이블
        self.amountLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
        }
        
        // 현황 설명 레이블
        self.currentStatusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(40)
        }
        
        // 로딩 표시
        self.activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.navigationView.delegate = self
        self.transferConfirmModalView.delegate = self
    }
    
}
