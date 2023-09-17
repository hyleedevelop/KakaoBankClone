//
//  ReceiverListTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

class ReceiverListTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "ReceiverListTableViewCell"
    
    //MARK: - 계좌 정보 관련 속성
    
    // 은행 로고
    private let bankLogoImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    // 계좌 이름
    private let accountNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 계좌 번호
    private let accountNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 계좌 정보에 대한 스택뷰
    private lazy var accountStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.accountNameLabel, self.accountNumberLabel])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillEqually
        sv.spacing = 0
        return sv
    }()
    
    //MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        self.addSubview()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 하위뷰 추가
    private func addSubview() {
        self.contentView.addSubview(self.bankLogoImage)
        self.contentView.addSubview(self.accountStackView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 은행 로고
        self.bankLogoImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        // 계좌 정보 스택뷰
        self.accountStackView.snp.makeConstraints {
            $0.left.equalTo(self.bankLogoImage.snp.right).offset(15)
            $0.centerY.equalTo(self.bankLogoImage.snp.centerY)
            $0.height.equalTo(40)
        }
    }
    
    //MARK: - 뷰컨트롤러에서 호출되는 메서드
    
    func applyCellUI(image: UIImage, type: BankType, name: String, number: String) {
        self.bankLogoImage.image = image
        self.accountNameLabel.text = name
        self.accountNumberLabel.text = "\(type.rawValue.dropLast(2)) \(number)"  // ex) 우리은행 1234 -> 우리 1234
    }
    
}
