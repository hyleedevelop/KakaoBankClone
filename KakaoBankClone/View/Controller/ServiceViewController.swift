//
//  ServiceMenuViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import SnapKit

protocol ServiceMenuCollectionViewDelegate: AnyObject {
    func didSelectCollectionViewItem(at item: Int)
}

final class ServiceViewController: UIViewController {
    
    //MARK: - UI 속성
    
    // 헤더뷰(컬렉션뷰를 담고 있는 뷰)
    private let serviceHeaderView: ServiceHeaderView = {
        let view = ServiceHeaderView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0
        return view
    }()
    
    // 탭 메뉴 컬렉션뷰
    private let serviceMenuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        cv.register(ServiceMenuCollectionViewCell.self, forCellWithReuseIdentifier: ServiceMenuCollectionViewCell.identifier)
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.collectionViewLayout = flowLayout
        cv.backgroundColor = UIColor(themeColor: .white)
        cv.layer.borderColor = UIColor.blue.cgColor
        cv.layer.borderWidth = 1
        cv.layer.masksToBounds = false
//        cv.layer.shadowColor = UIColor(themeColor: .black).cgColor
//        cv.layer.shadowOpacity = 0.3
//        cv.layer.shadowOffset = CGSize(width: 0, height: 10)
//        cv.layer.shadowRadius = 2
        return cv
    }()
    
    // 탭 메뉴 하단의 강조 막대
    private let highlightBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .black)
        return view
    }()
    
    // 서비스 목록
    private let serviceListTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(ServiceTopAdTableViewCell.self, forCellReuseIdentifier: ServiceTopAdTableViewCell.identifier)
        tv.register(ServiceListTableViewCell.self, forCellReuseIdentifier: ServiceListTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = true
        tv.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        tv.backgroundColor = UIColor(themeColor: .white)
        tv.layer.borderColor = UIColor.green.cgColor
        tv.layer.borderWidth = 0
        return tv
    }()
    
    //MARK: - 델리게이트 및 인스턴스
    
    // 델리게이트 속성
    weak var delegate: ServiceMenuCollectionViewDelegate?
    
    // 뷰모델의 인스턴스
    private let viewModel = ServiceViewModel()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.setupView()
        
        self.addSubview()
        self.setupDelegate()
        self.setupAutoLayout()
    }

    //MARK: - 메서드
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 등록
    private func addSubview() {
        self.view.addSubview(self.serviceListTableView)
        self.view.addSubview(self.serviceHeaderView)
        self.view.addSubview(self.serviceMenuCollectionView)
        //self.serviceMenuCollectionView.addSubview(self.highlightBar)
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.serviceListTableView.delegate = self
        self.serviceListTableView.dataSource = self
        
        self.serviceMenuCollectionView.delegate = self
        self.serviceMenuCollectionView.dataSource = self
        
        self.serviceMenuCollectionView.delegate = self
    }
    
    // 오토레이아웃 설정
    private func setupAutoLayout() {
        self.serviceListTableView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.serviceHeaderView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceViewLayout.headerMaxHeight)
        }
        
        self.serviceMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.serviceHeaderView.snp.bottom)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceViewLayout.menuCollectionViewHeight)
        }
        
        // 강조 막대의 왼쪽 끝 지점의 x 좌표값
//        self.highlightBar.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(self.serviceMenuCollectionView.snp.bottom).offset(38)
//            $0.height.equalTo(2)
//            $0.width.equalTo(25)
//        }
        
        // 화면에 처음 켜졌을 때, 테이블뷰의 ScrollView Offset과 Content Inset 설정
        self.serviceListTableView.contentOffset.y = -ServiceViewLayout.headerMaxHeight
        self.serviceListTableView.contentInset.top = ServiceViewLayout.headerMaxHeight
    }

}

//MARK: - 컬렉션뷰 델리게이트 메서드

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSectionsInCollectionView
    }
    
    // section 내 아이템의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSections
    }
    
    // 각 아이템마다 실행할 내용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuCollectionViewCell else { return UICollectionViewCell() }
        cell.serviceNameLabel.text = self.viewModel.titleForItemAt(at: indexPath.item)
        cell.serviceNameLabel.textColor = UIColor(white: 0.5, alpha: 1.0)
        return cell
    }
    
    // 아이템이 선택되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuCollectionViewCell else { fatalError() }
            
        print(cell.directionalLayoutMargins.leading)
        
//        if let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) {
//            let highlightBarMinX = layoutAttributes.frame.minX
//            print("minX: \(highlightBarMinX)")
//
//            UIView.animate(withDuration: 0.3) {
//                self.highlightBar.snp.updateConstraints {
//                    $0.centerX.equalTo(self.serviceMenuCollectionView).offset(highlightBarMinX)
//                }
//                self.view.layoutIfNeeded()
//            }
//        }
        
        if (0..<4) ~= indexPath.item {
            delegate?.didSelectCollectionViewItem(at: indexPath.item)
            self.serviceListTableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.item), at: .top, animated: true)
        }

    }
    
    // 아이템이 해제되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 없음
    }
    
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: ServiceViewLayout.menuCollectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 20, height: ServiceViewLayout.menuCollectionViewHeight)
    }
    
    // 각 셀의 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.sizeForItemAt(at: indexPath.item)
    }

}

//MARK: - 테이블뷰 델리게이트 메서드

extension ServiceViewController: UITableViewDataSource, UITableViewDelegate {
    
    // section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    // row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(at: section)
    }
    
    // row의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellHeight(at: indexPath.section)
    }
    
    // header의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.headerHeight(at: section)
    }
    
    // footer의 높이
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewModel.footerHeight(at: section)
    }
    
    // header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let titleLabel = UILabel(
                frame: CGRect(x: 25, y: 0, width: tableView.frame.width, height: 22)
            )
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            titleLabel.textColor = UIColor.black
            titleLabel.text = self.viewModel.categoryName[section]
            
            let headerView = UIView()
            headerView.addSubview(titleLabel)
            
            return headerView
        }
    }
    
    // footer view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.viewForFooterInSection(at: section)
    }
    
    // 셀에 표출할 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {  // 0번째 section: 상단 광고 컬렉션뷰
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTopAdTableViewCell.identifier, for: indexPath)
                    as? ServiceTopAdTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setAd(model: self.viewModel.getTopAdData)
            return cell
        }
        else {  // 나머지 section: 서비스 목록 테이블뷰
            let data = self.viewModel.serviceListData[indexPath.section-1][indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceListTableViewCell.identifier, for: indexPath)
                    as? ServiceListTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.accessoryType = data.hasInterest ? .none : .disclosureIndicator
            cell.setValue(
                title: data.title,
                subtitle: data.subtitle,
                interest: data.interest ?? "",
                color: data.tintColor
            )
            return cell
        }
    }
    
    // 셀이 선택 되었을때 수행할 내용
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
    }
    
    // 테이블뷰의 스크롤이 완료되었을 때 수행할 내용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 이 조건문이 없으면 컬렉션뷰를 스크롤 할 때에도 이 델리게이트 메서드가 실행됨 (주의)
        guard scrollView == self.serviceListTableView else { return }
        
        // 현재 테이블뷰의 스크롤의 위치
        let currentOffset: CGFloat = -scrollView.contentOffset.y
        // 현재 제목의 투명도
        let minimum: CGFloat = ServiceViewLayout.headerMinHeight + ServiceViewLayout.topSafeAreaHeight
        let maximum: CGFloat = ServiceViewLayout.headerMaxHeight + ServiceViewLayout.topSafeAreaHeight
        let currentTitleAlpha = 1 - ((maximum-currentOffset) /
                                     (maximum-minimum))
        print(minimum, maximum)
        
        // 스크롤 정도에 따라 제목 글씨의 투명도가 변하도록 설정
        self.serviceHeaderView.tabTitleLabel.textColor = UIColor(white: 0.0, alpha: currentTitleAlpha)
        
        // 스크롤 정도에 따라 투명도와 오토레이아웃이 변하도록 설정
        // 1) 헤더뷰 높이가 최대값으로 유지되는 구간
        if currentOffset >= maximum {
            self.serviceHeaderView.alpha = 1
            self.serviceMenuCollectionView.alpha = 1
            self.serviceHeaderView.snp.updateConstraints {
                $0.height.equalTo(ServiceViewLayout.headerMaxHeight)
            }
            print("1) 헤더뷰 높이가 최대값으로 유지되는 구간")
        }
        // 2) 헤더뷰 높이가 변하는 구간
        else if currentOffset < maximum && currentOffset >= minimum {
            self.serviceHeaderView.alpha = 1
            self.serviceMenuCollectionView.alpha = 1
            self.serviceHeaderView.snp.updateConstraints {
                $0.height.equalTo(currentOffset-ServiceViewLayout.topSafeAreaHeight)
            }
            print("2) 헤더뷰 높이가 변하는 구간")
        }
        // 3) 헤더뷰 높이가 최소값으로 유지되는 구간
        else {
            self.serviceHeaderView.alpha = 0.99
            self.serviceMenuCollectionView.alpha = 0.99
            self.serviceHeaderView.snp.updateConstraints {
                $0.height.equalTo(ServiceViewLayout.headerMinHeight)
            }
            print("3) 헤더뷰 높이가 최소값으로 유지되는 구간")
        }
        
        print(minimum, currentOffset, maximum, self.serviceHeaderView.frame.height)
    }
    
}

//MARK: - 헤더뷰에 대한 커스텀 델리게이트 메서드

extension ServiceViewController: ServiceMenuCollectionViewDelegate {
    
    // 메뉴 컬렉션뷰의 아이템을 눌렀을 때 테이블뷰의 특정 section으로 이동하기
    func didSelectCollectionViewItem(at item: Int) {

    }
    
}
