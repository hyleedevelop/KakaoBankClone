//
//  AlertTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit

class AlertTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "AlertTableViewCell"
    
    //MARK: - 계좌 정보 관련 속성
    
    // 알림 로고 이미지
    private let logoImage: UIImageView = {
        let view = UIImageView()
        view.tintColor = UIColor(themeColor: .black)
        return view
    }()
    
    // 알림 제목 레이블
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 알림 내용 레이블
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 알림 날짜 레이블
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 레이블 스택뷰
    private lazy var labelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel, self.dateLabel])
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
        self.contentView.addSubview(self.logoImage)
        self.contentView.addSubview(self.labelStackView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 로고 이미지
        self.logoImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(30)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }
        
        // 레이블 스택뷰
        self.labelStackView.snp.makeConstraints {
            $0.left.equalTo(self.logoImage.snp.right).offset(15)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(3)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    //MARK: - 뷰컨트롤러에서 호출되는 메서드
    
    func setCellUI(image: UIImage, title: String, content: String, date: String) {
        self.logoImage.image = image
        self.titleLabel.text = title
        self.contentLabel.text = content
        self.dateLabel.text = date
    }

}
