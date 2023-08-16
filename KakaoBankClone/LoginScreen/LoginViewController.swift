//
//  LoginViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/16.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class LoginViewController: UIViewController {

    //MARK: - UI 속성
    
    // 로고 이미지
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "b.circle")
        iv.tintColor = UIColor(themeColor: .black)
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        return iv
    }()
    
    // 이메일 텍스트필드
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(themeColor: .black)
        tf.placeholder = "이메일"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // 비밀번호 텍스트필드
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(themeColor: .black)
        tf.placeholder = "비밀번호"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    // 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.login.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.addSubview()
        self.setupLayout()
        self.setupDelegate()
    }
    
    //MARK: - 내부 메서드
    
    // 뷰 설정
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(themeColor: .yellow)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.view.addSubview(self.logoImageView)
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.passwordTextField)
        self.view.addSubview(self.loginButton)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 로고 이미지뷰
        self.logoImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
            $0.centerX.equalTo(self.view.safeAreaLayoutGuide)
            $0.width.height.equalTo(80)
        }
        
        // 이메일 텍스트필드
        self.emailTextField.snp.makeConstraints {
            $0.top.equalTo(self.logoImageView.snp.bottom).offset(100)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
        
        // 비밀번호 텍스트필드
        self.passwordTextField.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(10)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
        
        // 로그인 버튼
        self.loginButton.snp.makeConstraints {
            $0.top.equalTo(self.passwordTextField.snp.bottom).offset(100)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(50)
        }
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    // 로그인 버튼을 눌렀을 때 실행할 내용 설정
    @objc private func buttonTapped(_ button: UIButton) {
        // 계산결과 VC 인스턴스 생성
        let vc = TabBarController()
        // 계산결과 VC에 Navigation VC 넣기
        let nav = UINavigationController(rootViewController: vc)
        
        // Bottom Sheet 관련 설정
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        nav.isModalInPresentation = true  // true이면 쓸어내리기 불가능
        
        // 화면 전환
        self.present(nav, animated: true, completion: nil)
    }
    
}

//MARK: - 테이블뷰 델리게이트 메서드

extension LoginViewController: UITextFieldDelegate {
    
    
    
}
