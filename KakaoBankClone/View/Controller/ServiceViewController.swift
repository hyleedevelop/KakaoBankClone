//
//  ServiceMenuViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import SnapKit

final class ServiceViewController: UIViewController {
    
    //MARK: - UI 속성
    
    // sticky 헤더뷰
    let serviceHeaderView = ServiceHeaderView()
    let minHeight: CGFloat = 170
    let maxHeight: CGFloat = 170
    var currentHeightConstraint = NSLayoutConstraint()
    
    // 서비스 목록
    private var serviceListTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(ServiceTopAdTableViewCell.self, forCellReuseIdentifier: ServiceTopAdTableViewCell.identifier)
        tv.register(ServiceListTableViewCell.self, forCellReuseIdentifier: ServiceListTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = true
        tv.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        //tv.separatorStyle = .none
        return tv
    }() {
        didSet {
            self.serviceListTableView.contentInset = UIEdgeInsets(top: self.maxHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    //MARK: - 인스턴스
    
    // 뷰모델의 인스턴스
    private let viewModel = ServiceViewModel()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.setupView()
        self.setupHeaderView()
        self.setupTableView()
    }

    //MARK: - 메서드
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        //self.navigationController?.applyCustomSettings(color: .white, topInset: 25)
        //self.navigationItem.titleView?.backgroundColor = UIColor(themeColor: .white)
        self.navigationController?.navigationBar.isHidden = true
        //self.navigationController?.hidesBarsOnSwipe = false
        //self.navigationItem.title = "상품/서비스"
    }
    
    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // sticky 헤더뷰 설정
    private func setupHeaderView() {
        self.view.addSubview(self.serviceHeaderView)
        self.serviceHeaderView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(self.maxHeight)
        }
    }
    
    // 테이블뷰 설정
    private func setupTableView() {
        self.view.addSubview(self.serviceListTableView)
        self.serviceListTableView.snp.makeConstraints {
            $0.top.equalTo(self.serviceHeaderView.snp.bottom)
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.serviceListTableView.delegate = self
        self.serviceListTableView.dataSource = self
        self.serviceListTableView.backgroundColor = UIColor(themeColor: .white)
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
            titleLabel.text = self.viewModel.categoryName[section-1]
            
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
            
//            let bottomBorder = CALayer()
//            bottomBorder.frame = CGRect(x: 0.0, y: cell.contentView.frame.size.height, width: cell.contentView.frame.size.width, height: 0.5)
//            bottomBorder.backgroundColor = UIColor(white: 0.8, alpha: 1.0).cgColor
//            cell.contentView.layer.addSublayer(bottomBorder)
            
            return cell
        }
    }
    
    // 셀이 선택 되었을때 수행할 내용
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    // 테이블뷰의 스크롤이 완료되었을 때 수행할 내용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffset: CGFloat = scrollView.contentOffset.y  // 현재 content offset 값
        let thresholdContentOffset: CGFloat = 100.0  // 기준 content offset 값
        let minimumHeight: CGFloat = 50.0  // 최소한의 height 값
        //var serviceHeaderViewHeight: CGFloat = max(thresholdContentOffset - currentContentOffset, minimumTopInset)
        
        //if currentContentOffset <= thresholdContentOffset { print(#function, currentContentOffset) }
        if currentContentOffset > 0 { print(#function, currentContentOffset) }

        self.serviceHeaderView.tabTitleLabel.textColor = UIColor(
            white: 0.0,
            alpha: 1 - min((thresholdContentOffset/minimumHeight) * currentContentOffset/thresholdContentOffset, 1)
        )
        
//        if currentContentOffset < 0 {
//            self.serviceHeaderView.snp.makeConstraints {
//                $0.height.equalTo(max(abs(currentContentOffset), minimumHeight))
//            }
//        } else {
//            self.serviceHeaderView.snp.makeConstraints {
//                $0.height.equalTo(minimumHeight)
//            }
//        }
        
//        self.navigationController?.applyCustomSettings(
//            color: .white,
//            topInset: min(max(minimumTopInset - currentContentOffset, 0), thresholdContentOffset)
//        )
    }
    
}

//MARK: - 컬렉션뷰 델리게이트 메서드 (1)

extension ServiceViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // section 내 아이템의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // 각 아이템마다 실행할 내용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuCollectionViewCell else { return UICollectionViewCell() }
        cell.serviceNameLabel.text = "전체"
        return cell
    }
    
    // 아이템이 선택되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    // 아이템이 해제되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    }
    
}

//MARK: - 컬렉션뷰 델리게이트 메서드 (2)

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 12, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 12, height: 30)
    }
    
    // 각 셀의 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 30)
    }
    
}
