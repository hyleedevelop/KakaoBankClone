//
//  ServiceTableHeaderView.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/09.
//

import UIKit
import SnapKit

protocol ServiceHeaderViewDelegate: AnyObject {
    func didSelectCollectionViewItem(at section: Int)
}

class ServiceHeaderView: UIView {
    
    //MARK: - UI 속성
    
    // 탭 메뉴 컬렉션뷰
    private let serviceMenuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        cv.register(ServiceMenuCollectionViewCell.self, forCellWithReuseIdentifier: ServiceMenuCollectionViewCell.identifier)
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.collectionViewLayout = flowLayout
        cv.backgroundColor = UIColor(themeColor: .white)
        cv.layer.borderColor = UIColor.red.cgColor
        cv.layer.borderWidth = 0.5
        return cv
    }()
    
    // 델리게이트 속성
    weak var delegate: ServiceHeaderViewDelegate?
    
    // 화면 제목
    let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(themeColor: .black)
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = NavigationBarTitle.serviceMenu.rawValue
        return label
    }()
    
    //MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.setupCollectionView()
        self.setupTabTitleLabel()
        self.setupMenuCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드

    // 뷰 설정
    private func setupView() {
        self.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 화면 상단 제목 설정
    private func setupTabTitleLabel() {
        self.addSubview(self.tabTitleLabel)
        self.tabTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(25)
        }
    }
    
    // 컬렉션뷰 설정
    private func setupCollectionView() {
        self.serviceMenuCollectionView.delegate = self
        self.serviceMenuCollectionView.dataSource = self
    }
    
    // 메뉴 컬렉션뷰 설정
    private func setupMenuCollectionView() {
        self.addSubview(self.serviceMenuCollectionView)
        self.serviceMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.tabTitleLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(ServiceViewLayout.menuCollectionViewHeight)
        }
    }
}

extension ServiceHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // section 내 아이템의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    // 각 아이템마다 실행할 내용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuCollectionViewCell else { return UICollectionViewCell() }
        cell.serviceNameLabel.textColor = UIColor(white: 0.5, alpha: 1.0)
        switch indexPath.row {
        case 0: cell.serviceNameLabel.text = "전체"
        case 1: cell.serviceNameLabel.text = "예적금"
        case 2: cell.serviceNameLabel.text = "카드"
        case 3: cell.serviceNameLabel.text = "대출"
        default: break
        }
        return cell
    }
    
    // 아이템이 선택되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
        //        as? ServiceMenuCollectionViewCell else { fatalError() }
        //cell.serviceNameLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        print(#function, indexPath.item)
        
        delegate?.didSelectCollectionViewItem(at: indexPath.item)
        
    }
    
    // 아이템이 해제되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuCollectionViewCell else { fatalError() }
        //cell.serviceNameLabel.textColor = UIColor(white: 0.5, alpha: 1.0)
    }
    
}

extension ServiceHeaderView: UICollectionViewDelegateFlowLayout {
    
    // 각 셀의 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: ServiceViewLayout.menuCollectionViewHeight)
    }
    
}
