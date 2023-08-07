//
//  AccountTopAdTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit
import SnapKit

class AccountTopAdTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "AccountTopAdTableViewCell"
    
    //MARK: - 컨테이너 뷰 관련 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(themeColor: .transparentBlack)
        return view
    }()
    
    //MARK: - 제목 관련 속성
    
    // 제목
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 부제목
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 제목과 부제목을 묶은 스택뷰
    private lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
        sv.axis = .vertical
        sv.spacing = 5
        return sv
    }()
    
    //MARK: - 이미지 관련 속성
    
    private let adImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    //MARK: - 생성자
    
    // TableViewCell 생성자 셋팅 (1)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
 
        self.setupUI()
        self.setupAutoLayout()
    }
    
    // TableViewCell 생성자 셋팅 (2)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 메서드
    
    // UI 설정
    private func setupUI() {
        //self.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        // 컨테이너 뷰 설정
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        // 스택뷰 설정
        self.containerView.addSubview(self.titleStackView)
        self.titleStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-25)
        }
        
        // 이미지 설정
        self.containerView.addSubview(self.adImage)
        self.adImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(50)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
    // 광고 내용 설정
    func setAd(title: String, subtitle: String, image: UIImage) {
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.adImage.image = image
    }
}
