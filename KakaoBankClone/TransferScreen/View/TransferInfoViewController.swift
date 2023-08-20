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
    
    // 내 계좌 선택 버튼
    private let myAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("현금창고(xxxx): 300,000원", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        return button
    }()
    
    // 금액을 추가 버튼 생성: createAmountAddButton() 메서드 참고
    private let addAmountStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 15
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
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.next.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .light)
        button.backgroundColor = UIColor(themeColor: .yellow)
        button.isEnabled = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = false
        return button
    }()
    
    // 금액 레이블
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .transparentBlack)
        label.font = UIFont.monospacedSystemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "보낼금액"
        return label
    }()
    
    //MARK: - 인스턴스 및 데이터 속성
    
    // 뷰모델의 인스턴스
    private let viewModel = TransferInfoViewModel()
    
    // 계좌 데이터
    //private var db = [ReceiverListModel]()
    
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

    //MARK: - 메서드
    
    // 보낼금액을 입력하는 키패드 버튼 생성
    private func createKeypadButtons() {
        // 버튼 제목
        let buttonTitles: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "00", "0", "<-"]
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
                    button.setTitle(buttonTitles[buttonIndex], for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
                    button.setTitleColor(UIColor(themeColor: .black), for: .normal)
                }
                button.tag = buttonIndex  // 0 ~ 11
                //button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
                
                buttonIndex += 1
            }
            
            self.keypadStackView.addArrangedSubview(rowStackView)
        }
    }
    
    // 보낼금액을 추가할 수 있는 버튼 생성
    private func createAmountAddButtons() {
        // 버튼 제목
        let buttonTitles: [String] = ["+1만", "+5만", "+10만", "전액"]
        // 열의 개수
        let columnCount = 4
        for index in (0..<columnCount) {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitles[index], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            button.setTitleColor(UIColor(themeColor: .darkGray), for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor(themeColor: .darkGray).cgColor
            button.layer.cornerRadius = 5
            button.clipsToBounds = false
            button.tag = index + 20  // 20 ~ 23
            self.addAmountStackView.addArrangedSubview(button)
        }
    }
    
    // 뷰 설정
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.view.addSubview(self.navigationView)
        self.view.addSubview(self.amountLabel)
        self.view.addSubview(self.nextButton)
        self.view.addSubview(self.keypadStackView)
        self.view.addSubview(self.addAmountStackView)
        self.view.addSubview(self.myAccountButton)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 네비게이션 뷰
        self.navigationView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(TransferLayoutValues.transferInfoNavigatoinViewHiehgt)
        }
        
        // 보낼금액 레이블
        self.amountLabel.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.top.equalTo(self.navigationView.snp.bottom).offset(120)
            $0.height.equalTo(50)
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
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
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
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.navigationView.delegate = self
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
