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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //layout.itemSize = CGSize(width: 200, height: 300)
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.register(
            ServiceTopAdCollectionViewCell.self,
            forCellWithReuseIdentifier: CellIdentifier.serviceTopAdCollectionView.rawValue
        )
        cv.layer.cornerRadius = 20
        cv.clipsToBounds = true
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.direction = .leftToRight
        pc.currentPageIndicatorTintColor = UIColor(themeColor: .white)
        pc.pageIndicatorTintColor = UIColor(themeColor: .darkGray)
        return pc
    }()
    
    private var currentPage = 0 {
        didSet {
            self.pageControl.currentPage = currentPage
        }
    }

    //MARK: - 모델 관련 속성
    
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
    
    private func setupCollectionView() {
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func setupPageControl() {
        self.contentView.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints {
            $0.top.equalTo(self.collectionView).offset(10)
            $0.right.equalTo(self.collectionView).offset(10)
        }
    }
    
    //MARK: - 외부에서 호출하는 메서드
    
    // 광고 내용 설정
    func setAd(model: [ServiceTopAdModel]) {
        self.serviceTopAdModel = model
        self.collectionView.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceTopAdCollectionViewCell.identifier, for: indexPath) as? ServiceTopAdCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.red
        cell.setupAd(with: self.serviceTopAdModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ServiceTopAdTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        self.currentPage = Int(scrollView.contentOffset.x / width)
    }
}
