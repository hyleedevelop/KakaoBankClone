//
//  ServiceBigAdTableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/06.
//

import UIKit
import SnapKit

class ServiceTopAdTableViewCell: UITableViewCell {

    //MARK: - 식별자
    
    static let identifier = "ServiceTopAdTableViewCell"
    
    //MARK: - 컬렉션뷰 관련 속성
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(
            ServiceTopAdCollectionViewCell.self,
            forCellWithReuseIdentifier: ServiceTopAdCollectionViewCell.identifier
        )
        cv.layer.cornerRadius = 10
        cv.layer.masksToBounds = true
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.direction = .leftToRight
        pc.currentPageIndicatorTintColor = UIColor(themeColor: .white)
        pc.pageIndicatorTintColor = UIColor(themeColor: .faintGray)
        pc.hidesForSinglePage = false
        return pc
    }()

    //MARK: - 모델 및 기타 속성
    
    private var nowPage = 0
    private var serviceTopAdModel = [ServiceTopAdModel]()
    
    //MARK: - 생성자
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        self.setupCollectionView()
        self.setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 컬렉션뷰 설정
    private func setupCollectionView() {
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
            $0.top.equalToSuperview().offset(ServiceLayoutValues.headerMaxHeight)
            $0.height.equalTo(283)
        }
        
        self.containerView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    // 페이지컨트롤 설정
    private func setupPageControl() {
        self.contentView.addSubview(self.pageControl)
        
        self.pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.right.equalToSuperview().offset(5)
        }

        // indicator의 점 크기 조절
        self.pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // section header의 구분선만 제거하기
        let width = subviews[0].frame.width
        for view in subviews where view != contentView {
            if view.frame.width == width {
                view.removeFromSuperview()
            }
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 광고 설정
    func setAd(model: [ServiceTopAdModel]) {
        self.serviceTopAdModel = model
        self.pageControl.numberOfPages = self.serviceTopAdModel.count - 2
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ServiceTopAdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.serviceTopAdModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceTopAdCollectionViewCell.identifier, for: indexPath)
                as? ServiceTopAdCollectionViewCell else { return UICollectionViewCell() }
        cell.setupAd(with: self.serviceTopAdModel[indexPath.row])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ServiceTopAdTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let intValue = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        
        // 컬렉션뷰의 아이템 스크롤 설정
        switch intValue {
        case 0:
            let last = self.serviceTopAdModel.count - 2
            self.collectionView.scrollToItem(at: [0, last], at: .left, animated: false)
        case self.serviceTopAdModel.count - 1:
            self.collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
        default:
            break
        }
        
        // 페이지컨트롤의 현재페이지 번호 설정
        switch intValue {
        case 3:
            self.pageControl.currentPage = 0
        case 4:
            self.pageControl.currentPage = 1
        default:
            self.pageControl.currentPage = intValue
        }
    }
    
}
