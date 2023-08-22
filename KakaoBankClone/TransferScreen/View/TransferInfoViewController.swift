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
    private let navigationView: TransferInfoNavigationView = {
        let view = TransferInfoNavigationView()
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    // 레이블 컨테이너 뷰
    private let amountStatusContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .white)
        return view
    }()
    
    // 금액 레이블
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .transparentBlack)
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "보낼금액"
        return label
    }()
    
    // 현황 설명 레이블
    private let currentStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    // 내 계좌 선택 버튼
    private let myAccountButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        return button
    }()
    
    // 내 계좌 선택 레이블
    private let myAcountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = ""
        return label
    }()
    
    // 받는 분에게 표기 컨테이너 뷰
    private let yourTransactionContainerView: UIView = {
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
    private let yourTransactionNicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "받는 분에게 표기"
        return label
    }()
    
    // 받는 분에게 표기 텍스트필드
    private let yourTransactionNicknameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = UserDefaults.standard.userID
        tf.textAlignment = .right
        return tf
    }()
    
    // 나에게 표기 컨테이너 뷰
    private let myTransactionContainerView: UIView = {
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
    private let myTransactionNicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "나에게 표기"
        return label
    }()
    
    // 나에게 표기 텍스트필드
    private let myTransactionNicknameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "미입력시 수취인명"
        tf.textAlignment = .right
        return tf
    }()
    
    // 금액을 추가 버튼 생성: createAmountAddButton() 메서드 참고
    private let addAmountStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 7
        return sv
    }()
    
    // 금액 버튼 스택뷰: createKeypadButton() 메서드 참고
    private let keypadStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 0
        return sv
    }()
    
    // 다음 버튼
    private lazy var nextButton: UIButton = {
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
    
    //MARK: - 인스턴스 및 기타 속성
    
    // 뷰모델의 인스턴스
    private let viewModel = TransferInfoViewModel()
    
    // 계좌 데이터
    //private var db = [ReceiverListModel]()
    
    // 보낼금액(원)
    private var currentInputAmount: Int = 0 {
        didSet {
            // 보낼금액 값이 변할 때마다 UI가 변경 메서드 실행
            self.changeUI()
        }
    }
    // 계좌 잔고(원)
    private var currentBalance: Int = 1_000_000
    
    // 다음 버튼을 최초로 탭 하는지에 대한 여부
    private var firstTapOnTheNextButton: Bool = true
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firestore에서 DB를 가져오기 전에 실행할 내용
        self.setupView()
        
        // Firestore에서 DB를 가져온 후에 실행할 내용
        //self.viewModel.fetchReceiverAccountDataFromServer() { db in
            //self.db = db
        self.createKeypadButtons()
        self.createAmountAddButtons()
        
        self.addSubview()
        self.setupLayout()
        self.setupDelegate()
        //}
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
        self.view.addSubview(self.amountStatusContainerView)
        
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
        
        //let myAccountButtonTitle = "현금창고(xxxx): \(self.currentBalance.commaSeparatedWon)원"
        //self.myAccountButton.setTitle(myAccountButtonTitle, for: .normal)
        
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
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.navigationView.delegate = self
    }
    
    //MARK: - 특정 상황에서만 실행되는 메서드
    
    // 금액 추가 버튼을 눌렀을 때 실행할 내용
    @objc private func addAmountButtonTapped(_ button: UIButton) {
        // 보낼금액을 일정 금액만큼 추가하면 currentInputAmount의 속성감시자에 의해 UI 변경 메서드가 실행됨
        if button.tag == 20 { self.currentInputAmount += 10_000 }
        if button.tag == 21 { self.currentInputAmount += 50_000 }
        if button.tag == 22 { self.currentInputAmount += 100_000 }
        if button.tag == 23 { self.currentInputAmount = self.currentBalance }
    }
    
    // 키패드 버튼을 눌렀을 때 실행할 내용
    @objc private func keypadButtonTapped(_ button: UIButton) {
        // 1~9 버튼을 누른 경우
        if (0...8) ~= button.tag {
            guard String(self.currentInputAmount).count < 10 else { return }  // 보낼금액 자리수 제한
            self.currentInputAmount = self.currentInputAmount * 10 + (Int(button.currentTitle!) ?? 0)
        }
        // 00 버튼을 누른 경우
        if button.tag == 9 {
            guard String(self.currentInputAmount).count < 10 else { return }  // 보낼금액 자리수 제한
            self.currentInputAmount = self.currentInputAmount * 100
        }
        // 0 버튼을 누른 경우
        if button.tag == 10 {
            guard String(self.currentInputAmount).count < 10 else { return }  // 보낼금액 자리수 제한
            self.currentInputAmount *= 10
        }
        // <- 버튼을 누른 경우
        if button.tag == 11 {
            self.currentInputAmount /= 10
        }
        
        //print("보낼금액: \(self.currentInputAmount)원")
    }
    
    @objc private func nextButtonTapped(_ button: UIButton) {
        if self.firstTapOnTheNextButton {
            // 버튼이 활성화 된 경우 아래의 코드 실행
            guard button.isUserInteractionEnabled else { return }
            
            // 보낼금액 추가 및 키패드 버튼에 대한 UI를 화면에서 서서히 제거하기
            UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseInOut) {
                self.addAmountStackView.alpha = 0
                self.keypadStackView.alpha = 0
            }
            
            // 하위뷰 등록 및 오토레이아웃 설정
            self.view.addSubview(self.yourTransactionContainerView)
            self.view.addSubview(self.myTransactionContainerView)
            
            self.yourTransactionContainerView.addSubview(self.yourTransactionNicknameLabel)
            self.yourTransactionContainerView.addSubview(self.yourTransactionNicknameTextfield)
            
            self.myTransactionContainerView.addSubview(self.myTransactionNicknameLabel)
            self.myTransactionContainerView.addSubview(self.myTransactionNicknameTextfield)
            
            self.yourTransactionContainerView.snp.makeConstraints {
                $0.top.equalTo(self.myAccountButton.snp.bottom).offset(10)
                $0.left.right.equalTo(self.myAccountButton)
                $0.height.equalTo(44)
            }
            
            self.yourTransactionNicknameLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.equalToSuperview().offset(20)
                $0.width.equalToSuperview().multipliedBy(0.4)
            }
            
            self.yourTransactionNicknameTextfield.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.equalTo(self.yourTransactionNicknameLabel.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-20)
            }
            
            self.myTransactionContainerView.snp.makeConstraints {
                $0.top.equalTo(self.yourTransactionContainerView.snp.bottom).offset(10)
                $0.left.right.equalTo(self.myAccountButton)
                $0.height.equalTo(44)
            }
            
            self.myTransactionNicknameLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.equalToSuperview().offset(20)
                $0.width.equalToSuperview().multipliedBy(0.4)
            }
            
            self.myTransactionNicknameTextfield.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.left.equalTo(self.myTransactionNicknameLabel.snp.right).offset(10)
                $0.right.equalToSuperview().offset(-20)
            }
            
            // 받는 분에게 표기, 나에게 표기에 대한 UI를 화면에서 서서히 보여주기
            UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveEaseInOut) {
                self.yourTransactionContainerView.alpha = 1
                self.myTransactionContainerView.alpha = 1
            }
        } else {
            // modal view 띄우기 구현
            // ...
        }
    }

    // 보낼금액이 유효한지 확인하고 경우에 따라 UI 변경하기
    private func changeUI() {
        // 보낼금액이 0원인지의 여부에 따라 UI를 다르게 설정
        if self.currentInputAmount == 0 {
            self.amountLabel.text = "보낼금액"
            self.amountLabel.textColor = UIColor(themeColor: .transparentBlack)
            self.amountLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
            
            self.deactivateNextButton()
        } else {
            self.amountLabel.text = self.currentInputAmount.commaSeparatedWon + "원"
            self.amountLabel.textColor = UIColor(themeColor: .black)
            self.amountLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            
            // 보낼금액의 자리수에 따라 UI를 다르게 설정
            if String(self.currentInputAmount).count >= 5 {
                self.currentStatusLabel.text = self.currentInputAmount.koreanStyleWon + "원"
                self.currentStatusLabel.textColor = UIColor(themeColor: .darkGray)
            } else {
                self.currentStatusLabel.text = ""
                self.currentStatusLabel.textColor = UIColor.clear
            }
            
            // 보낼금액이 계좌잔고를 초과했는지의 여부에 따라 UI를 다르게 설정
            if self.currentInputAmount > self.currentBalance {
                self.amountLabel.textColor = UIColor(themeColor: .red)
                self.currentStatusLabel.textColor = UIColor(themeColor: .black)
                self.currentStatusLabel.text = "출금계좌 잔고 부족"
                
                self.deactivateNextButton()
            } else {
                self.amountLabel.textColor = UIColor(themeColor: .black)
                self.currentStatusLabel.textColor = UIColor(themeColor: .black)
                
                self.activateNextButton()
            }
        }
    }
    
    // 다음 버튼 활성화
    private func activateNextButton() {
        self.nextButton.backgroundColor = UIColor(themeColor: .yellow)
        self.nextButton.isUserInteractionEnabled = true
    }
    
    // 다음 버튼 비활성화
    private func deactivateNextButton() {
        self.nextButton.backgroundColor = UIColor(themeColor: .transparentBlack)
        self.nextButton.isUserInteractionEnabled = false
    }
    
}

//MARK: - 네비게이션 뷰에 대한 커스텀 델리게이트 메서드

extension TransferInfoViewController: TransferInfoNavigationViewDelegate {
    
    func backButtonTapped() {
        // 바로 직전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonTapped() {
        // 화면 빠져나오기
        self.dismiss(animated: true, completion: nil)
    }
    
}
