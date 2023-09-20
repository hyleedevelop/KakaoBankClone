//
//  ServiceListTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/06.
//

import UIKit
import SnapKit

class ServiceListTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "ServiceListTableViewCell"
    
    //MARK: - UI 속성
    
    // 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 부제목
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 제목에 대한 스택뷰
    private lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fill
        sv.spacing = 5
        return sv
    }()
    
    // 이자
    private let interestLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 제목 스택뷰와 이자에 대한 최종 스택뷰
    private lazy var finalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleStackView, self.interestLabel])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalCentering
        sv.spacing = 0
        return sv
    }()
    
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
        self.contentView.addSubview(self.finalStackView)
        self.finalStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-25)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 레이블에 표시할 값 설정
    func setCellUI(title: String, subtitle: String, interest: String, color: UIColor) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.interestLabel.text = interest
        self.interestLabel.textColor = color
    }

}
