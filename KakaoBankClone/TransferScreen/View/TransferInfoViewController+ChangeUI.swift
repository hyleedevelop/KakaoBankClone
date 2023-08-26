//
//  TransferInfoViewController+ChangeUI.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/26.
//

import UIKit
import SnapKit

extension TransferInfoViewController {
    
    //MARK: - 특정 상황에서만 실행되는 메서드
    
    // 금액 추가 버튼을 눌렀을 때 실행할 내용
    @objc internal func addAmountButtonTapped(_ button: UIButton) {
        // 보낼금액을 일정 금액만큼 추가하면 currentInputAmount의 속성감시자에 의해 UI 변경 메서드가 실행됨
        if button.tag == 20 { self.currentInputAmount += 10_000 }
        if button.tag == 21 { self.currentInputAmount += 50_000 }
        if button.tag == 22 { self.currentInputAmount += 100_000 }
        if button.tag == 23 { self.currentInputAmount = self.viewModel.currentBalance }
    }
    
    // 키패드 버튼을 눌렀을 때 실행할 내용
    @objc internal func keypadButtonTapped(_ button: UIButton) {
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
    
    @objc internal func nextButtonTapped(_ button: UIButton) {
        if self.nextButtonTapCount == 0 {
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
            
            self.nextButtonTapCount += 1
        } else {
            // 로딩 애니메이션 시작
            self.activityIndicator.startAnimating()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // 로딩 애니메이션 종료
                self.activityIndicator.stopAnimating()
                
                // modal view 띄우기 구현
                self.popoverModalView(
                    receiver: self.viewModel.selectedReceiverName,
                    receiverAccount: self.viewModel.selectedReceiverAccount,
                    amount: self.currentInputAmount
                )
            }
        }
    }

    // 보낼금액이 유효한지 확인하고 경우에 따라 UI 변경하기
    internal func changeUI() {
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
            if self.currentInputAmount > self.viewModel.currentBalance {
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
    internal func activateNextButton() {
        self.nextButton.backgroundColor = UIColor(themeColor: .yellow)
        self.nextButton.isUserInteractionEnabled = true
    }
    
    // 다음 버튼 비활성화
    internal func deactivateNextButton() {
        self.nextButton.backgroundColor = UIColor(themeColor: .transparentBlack)
        self.nextButton.isUserInteractionEnabled = false
    }
    
    // 이체 확인 모달뷰 화면에 띄우기
    internal func popoverModalView(receiver: String, receiverAccount: String, amount: Int) {
        // 모달뷰의 메세지 내용 작성
        self.transferConfirmModalView.setupMessage(
            selectedUserName: receiver,
            selectedUserAccount: receiverAccount,
            currentInputAmount: amount
        )
        
        // 하위뷰 추가
        self.view.addSubview(self.dimmingView)
        self.view.addSubview(self.transferConfirmModalView)
        
        // 초기 상태
        self.dimmingView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self.view)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dimmingViewTapped(_:)))
        self.dimmingView.addGestureRecognizer(tap)
        self.dimmingView.alpha = 0.0
        
        self.transferConfirmModalView.snp.makeConstraints {
            $0.height.equalTo(340)
            $0.top.equalTo(self.view.snp.bottom).offset(20)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.layoutIfNeeded()
        
        // 애니메이션 효과를 위해 레이아웃을 서서히 변경
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
            self.dimmingView.alpha = 0.7
            
            self.transferConfirmModalView.snp.removeConstraints()
            self.transferConfirmModalView.snp.updateConstraints {
                $0.height.equalTo(340)
                $0.top.equalTo(self.view.snp.bottom).offset(-340)
                $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc internal func dimmingViewTapped(_ view: UIView) {
        // 애니메이션 효과를 위해 레이아웃을 서서히 변경
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.dimmingView.alpha = 0.0
            
            self.transferConfirmModalView.snp.updateConstraints {
                $0.top.equalTo(self.view.snp.bottom).offset(20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
}

//MARK: - 네비게이션 뷰에 대한 커스텀 델리게이트 메서드

extension TransferInfoViewController: TransferInfoNavigationViewDelegate {
    
    // 돌아가기 버튼을 눌렀을 때 실행할 내용
    func backButtonTapped() {
        // 바로 직전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    // 취소 버튼을 눌렀을 때 실행할 내용
    func cancelButtonTapped() {
        // 화면 빠져나오기
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - 모달 뷰에 대한 커스텀 델리게이트 메서드

extension TransferInfoViewController: TransferConfirmModalViewDelegate {
    
    // 취소 버튼을 눌렀을 때 실행할 내용
    func dismissButtonTapped() {
        // 애니메이션 효과를 위해 레이아웃을 서서히 변경
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.dimmingView.alpha = 0.0
            
            self.transferConfirmModalView.snp.updateConstraints {
                $0.top.equalTo(self.view.snp.bottom).offset(20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    // 이체하기 버튼을 눌렀을 때 실행할 내용
    func transferButtonTapped() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
            self.transferConfirmModalView.snp.updateConstraints {
                $0.top.equalTo(self.view.snp.bottom).offset(20)
            }
            self.view.layoutIfNeeded()
        }
        
        // 로딩 애니메이션 시작
        self.activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            // 거래 내역 만들기 (Firestore)
            self.viewModel.makeTransactionHistory(
                senderID: UserDefaults.standard.userID,
                receiverID: self.viewModel.selectedReceiverID,
                amount: self.currentInputAmount) {
                    // 로딩 애니메이션 종료
                    self.activityIndicator.stopAnimating()
                    
                    // 바로 다음 화면으로 넘어가기
                    let nextVM = TransferCompleteViewModel(  // 다음 화면의 뷰모델
                        selectedReceiverName: self.viewModel.selectedReceiverName,
                        selectedReceiverAccount: self.viewModel.selectedReceiverAccount,
                        amount: self.currentInputAmount
                    )
                    let nextVC = TransferCompleteViewController(viewModel: nextVM)  // 다음 화면의 뷰컨트롤러
                    self.navigationController?.pushViewController(nextVC, animated: false)
                }
        }
    }
    
}


