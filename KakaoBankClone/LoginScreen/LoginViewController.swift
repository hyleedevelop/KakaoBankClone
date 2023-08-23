//
//  LoginViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/16.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth

protocol LoginUserInfoDelegate: AnyObject {
    func sendLoginUserInfo(userID: String)
}

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
        tf.keyboardType = .emailAddress
        tf.text = UserID.user1.rawValue + "@test.com"
        return tf
    }()
    
    // 비밀번호 텍스트필드
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(themeColor: .black)
        tf.placeholder = "비밀번호"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .asciiCapable
        tf.isSecureTextEntry = true
        tf.text = UserPassword.user1.rawValue
        return tf
    }()
    
    // 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.login.rawValue, for: .normal)
        button.setTitleColor(UIColor(themeColor: .black), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(themeColor: .transparentBlack)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    // 로딩 표시
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.stopAnimating()
        ai.style = .large
        return ai
    }()
    
    //MARK: - 델리게이트 속성
    
    weak var delegate: LoginUserInfoDelegate?
    
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
        self.view.addSubview(self.activityIndicator)
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
            $0.height.equalTo(60)
        }
        
        // 로딩 표시
        self.activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }

    // 로그인 버튼을 눌렀을 때 실행할 내용 설정
    @objc private func buttonTapped(_ button: UIButton) {
        // 로딩 애니메이션 시작
        self.activityIndicator.startAnimating()
        
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            // 로그인 성공 시
            if error == nil {
                
                // 다음 화면으로 사용자 아이디 전달하기
                //self.delegate?.sendLoginUserInfo(userID: String(email.dropLast(9)))
                UserDefaults.standard.userID = String(email.dropLast(9))
                
                // 다음 화면으로 넘어가기
                let tabBarController = TabBarController()
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let window = windowScene?.windows.first
                
                window?.rootViewController = tabBarController
                window?.makeKeyAndVisible()
                
                // iOS 15부터 아래의 방식은 deprecated 되었음
                //UIApplication.shared.windows.first?.rootViewController = tabBarController  // 탭바 컨트롤러를 새로운 rootViewController로 설정
                //UIApplication.shared.windows.first?.makeKeyAndVisible()  // key window로 지정하면서 화면 업데이트
                
                // 로딩 애니메이션 종료
                self.activityIndicator.stopAnimating()
            }
                        
            // 로그인 실패 시
            else {
                // 에러메세지 보여주기
                let alert = UIAlertController(
                    title: "로그인 실패",
                    message: "이메일 또는 비밀번호가 올바르지 않습니다.",
                    preferredStyle: .alert
                )
                alert.addAction(
                    UIAlertAction(title: "닫기", style: .default)
                )
                self.present(alert, animated: true)
                
                // 로딩 애니메이션 종료
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // 뷰(화면)를 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

//MARK: - 테이블뷰 델리게이트 메서드

extension LoginViewController: UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        <#code#>
//    }
    
    
}
