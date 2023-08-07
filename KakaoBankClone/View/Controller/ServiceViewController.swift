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
    
    // 탭 메뉴 컬렉션뷰
    private let tabMenuCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        cv.register(ServiceMenuBarCollectionViewCell.self, forCellWithReuseIdentifier: ServiceMenuBarCollectionViewCell.identifier)
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.collectionViewLayout = flowLayout
        cv.backgroundColor = UIColor.red
        return cv
    }()
    
    // 서비스 목록
    private let serviceListTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(ServiceTopAdTableViewCell.self, forCellReuseIdentifier: ServiceTopAdTableViewCell.identifier)
        tv.register(ServiceListTableViewCell.self, forCellReuseIdentifier: ServiceListTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = true
        tv.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        //tv.separatorStyle = .none
        return tv
    }()
    
    //MARK: - 인스턴스
    
    // 뷰모델의 인스턴스
    private let viewModel = ServiceViewModel()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.setupView()
        self.setupCollectionView()
        self.setupTableView()
    }

    //MARK: - 메서드
    
    // 네비게이션 바 설정
    private func setupNavigationBar() {
        // 커스텀 설정 적용
        self.navigationController?.applyCustomSettings(color: .white)
        self.navigationItem.titleView?.backgroundColor = UIColor(themeColor: .white)

        // 네비게이션 바 구성
        let title = self.navigationItem.makeTitle(
            title: NavigationBarTitle.serviceMenu.rawValue,
            color: UIColor(themeColor: .black)
        )
        
        self.navigationItem.leftBarButtonItems = [title]
        
//        // 네비게이션 바 구성
//        let stackView = self.navigationItem.makeTitleAndTabMenu(
//            title: NavigationBarTitle.serviceMenu.rawValue,
//            color: UIColor(themeColor: .black),
//            collectionView: self.tabMenuCollectionView
//        )
//
//        // 스택뷰를 내비게이션 바의 타이틀뷰로 설정
//        self.navigationItem.titleView = stackView
    }
    
    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
        self.serviceListTableView.backgroundColor = UIColor.clear
    }
    
    // 컬렉션뷰 설정
    private func setupCollectionView() {
//        self.navigationController!.navigationBar.addSubview(self.tabMenuCollectionView)
//        self.tabMenuCollectionView.snp.makeConstraints {
//            $0.left.equalTo(self.navigationController!.navigationBar).offset(10)
//            $0.right.equalTo(self.navigationController!.navigationBar).offset(-10)
//            $0.top.equalTo(self.navigationController!.navigationBar).offset(10)
//            $0.bottom.equalTo(self.navigationController!.navigationBar).offset(-10)
//        }
//
//        self.tabMenuCollectionView.delegate = self
//        self.tabMenuCollectionView.dataSource = self
    }
    
    // 테이블뷰 설정
    private func setupTableView() {
        self.view.addSubview(self.serviceListTableView)
        self.serviceListTableView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
        }
        
        // 대리자 지정
        self.serviceListTableView.delegate = self
        self.serviceListTableView.dataSource = self
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
        return self.viewModel.viewForHeaderInSection(tableView: tableView, at: section)
    }
    
    // footer view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.viewForFooterInSection(at: section)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.removeSectionSeparators()
//    }
    
    // 셀에 표출할 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {  // 0번째 section: 상단 광고 컬렉션뷰
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTopAdTableViewCell.identifier, for: indexPath)
                    as? ServiceTopAdTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setAd(model: self.viewModel.topAdData)
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
    
    // 각 셀마다 실행할 내용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuBarCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuBarCollectionViewCell else { return UICollectionViewCell() }
        cell.serviceNameLabel.text = "전체"
        return cell
    }
    
    // 셀이 선택되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ThemeCollectionViewCell
//
//        // 기존에 표출되고 있던 annotation을 없애고 선택한 타입의 annotation을 새롭게 표출
//        self.removeAnnotations()
//        for index in 0..<InfoType.allCases.count {
//            isAnnotationMarked[index] = false
//        }
//
//        if !self.isAnnotationMarked[indexPath.row] {
//            self.addAnnotationsOnTheMapView(with: InfoType(rawValue: indexPath.row)!)
//        }
//
//        self.viewModel.changeCellUI(cell: cell, selected: true)
    }
    
    // 셀이 해제되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! ThemeCollectionViewCell
//        self.viewModel.changeCellUI(cell: cell, selected: false)
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
