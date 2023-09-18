//
//  MoreTopAdTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/09/18.
//

import UIKit

class MoreTopAdTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "MoreTopAdTableViewCell"
    
    //MARK: - 상단 광고 관련 속성
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .blue)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // 광고 문구
    private let adLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    // 광고 이미지
    private let adImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor(themeColor: .black)
        return iv
    }()
    
    // > 이미지
    private let disclosureImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor(themeColor: .white)
        iv.image = UIImage(systemName: "chevron.right")!
        return iv
    }()

    // 4개의 버튼에 대한 스택뷰
    internal let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 20
        return sv
    }()
    
    //MARK: - 4개의 버튼 관련 속성
    
    
    //MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.createMultipleButtons(number: 4)
        self.setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 보낼금액을 추가할 수 있는 버튼 생성
    private func createMultipleButtons(number: Int) {
        let images: [(UIImage, String)] = [
            (UIImage(systemName: "face.smiling")!, "고객센터"),
            (UIImage(systemName: "lock.shield")!, "인증/보안"),
            (UIImage(systemName: "speaker.wave.3")!, "공지사항"),
            (UIImage(systemName: "gift")!, "이벤트"),
        ]
        
        for (image, title) in images {
            // 버튼 생성
            let button = UIButton(type: .custom)
            
            // 버튼 이미지 설정
            button.setImage(image, for: .normal)
            button.tintColor = UIColor(themeColor: .black)
            button.imageView?.contentMode = .scaleAspectFit
            
            // 버튼 타이틀 설정
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
            button.setTitleColor(UIColor(themeColor: .black), for: .normal)
            
            // 버튼 이미지 아래에 타이틀 배치 (verticalAlignment을 .bottom으로 설정)
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .bottom
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 0)  // 이미지 아래 여백 조절
            
            // 버튼 타이틀의 정렬 및 여백 조절
            button.titleLabel?.textAlignment = .center
            button.titleEdgeInsets = UIEdgeInsets(top: 25, left: -25, bottom: 0, right: 0)  // 타이틀 왼쪽 정렬 및 여백 조절
        
            self.buttonStackView.addArrangedSubview(button)
        }
    }
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        // 상단 광고 컨테이너 뷰
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(5)
            $0.height.equalTo(45)
        }
        
        // 상단 광고 이미지
        self.containerView.addSubview(self.adImage)
        self.adImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.width.equalTo(20)
            $0.height.equalToSuperview()
        }
        
        // 상단 광고 제목
        self.containerView.addSubview(self.adLabel)
        self.adLabel.snp.makeConstraints {
            $0.left.equalTo(self.adImage.snp.right).offset(15)
            $0.centerY.equalToSuperview()
        }
        
        // 상단 광고 disclosure 이미지
        self.containerView.addSubview(self.disclosureImage)
        self.disclosureImage.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        // 4개의 버튼
        self.contentView.addSubview(self.buttonStackView)
        self.buttonStackView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.top.equalTo(self.containerView.snp.bottom).offset(25)
            $0.height.equalTo(55)
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 뷰컨트롤러에서 값을 받아 UI 설정
    func setCellUI(image: UIImage, title: String) {
        self.adImage.image = image
        self.adLabel.text = title
    }

}
