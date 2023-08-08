//
//  ServiceTopAdCollectionViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/07.
//

import UIKit
import SnapKit

class ServiceTopAdCollectionViewCell: UICollectionViewCell {
    
    //MARK: - 식별자
    
    static let identifier = "ServiceTopAdCollectionViewCell"
    
    //MARK: - 컨테이너 뷰 관련 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - 제목 관련 속성
    
    // 제목
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 부제목
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 3
        return label
    }()
    
    // 제목과 부제목을 묶은 스택뷰
    private lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.subtitleLabel])
        sv.axis = .vertical
        sv.spacing = 6
        return sv
    }()
    
    //MARK: - 이미지 관련 속성
    
    let adImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor.black
        return iv
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    private func setupAutoLayout() {
        // 컨테이너뷰 설정
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        // 스택뷰 설정
        self.containerView.addSubview(self.titleStackView)
        self.titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(25)
            $0.right.equalToSuperview().offset(-25)
        }
        
        // 이미지 설정
        self.containerView.addSubview(self.adImage)
        self.adImage.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(150)
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 광고 설정
    func setupAd(with model: ServiceTopAdModel?) {
        if let model = model {
            self.backgroundColor = model.backgroundColor
            self.titleLabel.text = model.title
            self.subtitleLabel.attributedText = model.subtitle
            self.adImage.image = model.image
        }
    }
}
