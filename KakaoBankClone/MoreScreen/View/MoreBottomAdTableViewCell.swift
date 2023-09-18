//
//  MoreBottomAdTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/09/18.
//

import UIKit

class MoreBottomAdTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "MoreBottomAdTableViewCell"
    
    //MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
//        self.contentView.addSubview(self.titleLabel)
//        self.titleLabel.snp.makeConstraints {
//            $0.left.equalToSuperview().offset(25)
//            $0.right.equalToSuperview().offset(-25)
//            $0.top.equalToSuperview().offset(20)
//            $0.bottom.equalToSuperview().offset(-20)
//        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 뷰컨트롤러에서 값을 받아 UI 설정
//    func setCellUI(title: String) {
//        self.titleLabel.text = title
//    }

}
