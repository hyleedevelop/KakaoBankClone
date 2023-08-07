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
    
    //MARK: - 컬렉션뷰 관련 속성
    
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
            AccountTopAdCollectionViewCell.self,
            forCellWithReuseIdentifier: AccountTopAdCollectionViewCell.identifier
        )
        cv.layer.cornerRadius = 15
        cv.clipsToBounds = true
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.direction = .leftToRight
        pc.currentPageIndicatorTintColor = UIColor(themeColor: .white)
        pc.pageIndicatorTintColor = UIColor(themeColor: .darkGray)
        pc.hidesForSinglePage = false
        return pc
    }()
    
    private var nowPage = 0 {
        didSet {
            // 페이지를 수동으로 넘겼을 때 indicator가 현재 페이지를 나타내도록 설정
            self.pageControl.currentPage = self.nowPage
        }
    }
    
    //MARK: - 모델 관련 속성
    
    private var accountTopAdModel = [AccountTopAdModel]()
    
    //MARK: - 생성자
    
    // TableViewCell 생성자 셋팅 (1)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
 
        self.setupCollectionView()
        self.setupPageControl()
        self.adAutoTransition()
    }
    
    // TableViewCell 생성자 셋팅 (2)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 내부 메서드
    
    // 컬렉션뷰 설정
    private func setupCollectionView() {
        // 하위뷰로 등록 및 오토레이아웃 설정
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        // 대리자 설정
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    // 페이지컨트롤 설정
    private func setupPageControl() {
        // 하위뷰로 등록 및 오토레이아웃 설정
        self.contentView.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(20)
        }

        // indicator의 점 크기 조절
        self.pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }
    }
    
    // 광고 컬렉션뷰 자동 전환
    private func adAutoTransition() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
            self.nowPage += 1
            if self.nowPage > self.accountTopAdModel.count-1 {
                self.nowPage = 0
            }
            self.collectionView.scrollToItem(at: NSIndexPath(item: self.nowPage, section: 0) as IndexPath, at: .right, animated: true)
            self.pageControl.currentPage = self.nowPage
        }
    }
    
    //MARK: - 외부
    
    // 광고 설정
    func setAd(model: [AccountTopAdModel]) {
        self.accountTopAdModel = model
        self.pageControl.numberOfPages = self.accountTopAdModel.count
        self.collectionView.reloadData()
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension AccountTopAdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.accountTopAdModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountTopAdCollectionViewCell.identifier, for: indexPath)
                as? AccountTopAdCollectionViewCell else { return UICollectionViewCell() }
        cell.setupAd(with: self.accountTopAdModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension AccountTopAdTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        self.nowPage = Int(scrollView.contentOffset.x / width)
    }
    
}
