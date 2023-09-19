//
//  ServiceFooterAdView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/09/19.
//

import UIKit
import SnapKit

class ServiceFooterAdView: UIView {
    
    //MARK: - UI 속성
    
    // 광고 컨테이너 뷰
    private let adContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10
        return view
    }()
    
    // 광고 제목
    private let adTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .white)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 광고 부제목
    private let adSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .white)
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 레이블에 대한 스택뷰
    private lazy var adLabelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.adTitleLabel, self.adSubtitleLabel])
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fill
        sv.spacing = 0
        return sv
    }()
    
    // 광고 이미지
    private let adImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // 섹션 내부와 푸터 사이의 경계선을 덮어서 보이지 않게끔 하는 하얀색 뷰
    private let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .white)
        return view
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
    
    // 화면 상단 제목 설정
    private func setupAutoLayout() {
        // 컨테이너 뷰
        self.addSubview(self.adContainerView)
        self.adContainerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(75)
        }
        
        // 레이블 스택뷰
        self.adContainerView.addSubview(self.adLabelStackView)
        self.adLabelStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.top.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-18)
            $0.width.equalTo(240)
        }
        
        // 이미지
        self.adContainerView.addSubview(self.adImage)
        self.adImage.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalTo(50)
        }
        
        // 하얀색 뷰
        self.addSubview(self.whiteView)
        self.whiteView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-1)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 뷰컨트롤러에서 값을 받아 UI 설정
    func setupUI(backgroundColor: UIColor, title: String, subtitle: String, image: UIImage) {
        self.adContainerView.backgroundColor = backgroundColor
        self.adTitleLabel.text = title
        self.adSubtitleLabel.text = subtitle
        self.adImage.image = image
    }
    
}
