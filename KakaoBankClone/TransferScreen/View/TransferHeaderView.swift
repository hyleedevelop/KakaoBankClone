//
//  TransferHeaderView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

class TransferHeaderView: UIView {

    //MARK: - UI 속성
    
    // 화면 제목
    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = NavigationBarTitle.transfer.rawValue
        return label
    }()

    // 검색 바
    private let searchBar: UISearchBar = {
        let bar = UISearchBar()
        
        return bar
    }()
    
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
        self.addSubview(self.tabTitleLabel)
        self.addSubview(self.searchBar)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 제목 레이블
        self.tabTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.left.equalToSuperview().offset(25)
        }
        
        // 내 계좌 버튼
        self.searchBar.snp.makeConstraints {
            $0.left.right.equalTo(self.tabTitleLabel)
            $0.height.equalTo(40)
        }
    }

}
