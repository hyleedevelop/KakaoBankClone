//
//  TransferNavigationView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

protocol NavigationViewDelegate: AnyObject {
    func closeButtonTapped()
}

class TransferNavigationView: UIView {

    //MARK: - UI 속성
    
    // 내 계좌 버튼
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.close.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        button.backgroundColor = UIColor(themeColor: .white)
        return button
    }()
    
    //MARK: - 델리게이트 속성
    
    weak var delegate: NavigationViewDelegate?

    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.addSubview()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드

    // 뷰 설정
    private func setupView() {
        self.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.addSubview(self.closeButton)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 닫기 버튼
        self.closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo(40)
        }
        
        self.closeButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        self.delegate?.closeButtonTapped()
    }
}
