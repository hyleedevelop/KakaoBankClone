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
    
    //MARK: - UI 관련 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .lightGray)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // 광고 제목 문구
    private let adTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 광고 부제목 문구
    private let adSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .darkGray)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 레이블에 대한 스택뷰
    private lazy var adLabelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.adTitleLabel, self.adSubtitleLabel])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()
    
    // 광고 이미지
    private let adImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor(themeColor: .black)
        return iv
    }()
    
    // i 아이콘
    private let infoIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor(themeColor: .darkGray)
        iv.image = UIImage(systemName: "info.circle.fill")!
        return iv
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
        // 컨테이너 뷰
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(5)
            $0.height.equalTo(80)
        }
        
        // 레이블 스택뷰
        self.containerView.addSubview(self.adLabelStackView)
        self.adLabelStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(180)
        }
        
        // 이미지
        self.containerView.addSubview(self.adImage)
        self.adImage.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(50)
        }
        
        // i 아이콘
        self.containerView.addSubview(self.infoIcon)
        self.infoIcon.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.equalToSuperview().offset(2)
            $0.right.equalToSuperview().offset(-2)
        }
        
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 뷰컨트롤러에서 값을 받아 UI 설정
    func setCellUI(image: UIImage, title: String, subtitle: String) {
        self.adImage.image = image
        self.adTitleLabel.text = title
        self.adSubtitleLabel.text = subtitle
    }

}
