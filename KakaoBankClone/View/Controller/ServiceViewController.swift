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
    
    // 헤더뷰(컬렉션뷰를 담고 있는 뷰)
    private let serviceHeaderView: ServiceHeaderView = {
        let view = ServiceHeaderView()
        view.isHidden = false
        return view
    }()
    
//    // sticky 헤더뷰(컬렉션뷰를 담고 있는 뷰)
//    private let stickyServiceHeaderView: ServiceHeaderView = {
//        let view = ServiceHeaderView()
//        view.isHidden = true
//        return view
//    }()
    
    // 스택뷰
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 20
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
        self.setupHeaderView()
        self.setupTableView()
        self.setupStackView()
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
    
    // 헤더뷰 설정
    private func setupHeaderView() {
        self.serviceHeaderView.snp.makeConstraints {
            $0.height.equalTo(ServiceViewLayout.transparentTitleOffset)
        }
    }
    
    // 테이블뷰 설정
    private func setupTableView() {
        self.serviceListTableView.delegate = self
        self.serviceListTableView.dataSource = self
    }
    
    // 스택뷰 설정
    private func setupStackView() {
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.serviceHeaderView)
        self.stackView.addArrangedSubview(self.serviceListTableView)
        self.stackView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
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
            cell.backgroundColor = UIColor.green
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

    }
    
    // 테이블뷰의 스크롤이 완료되었을 때 수행할 내용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // scrollView.contentOffset.y: 현재 테이블뷰의 스크롤의 y 위치
        // ServiceViewLayout.stickyHeaderOffset: 헤더뷰가 고정되기 시작하는 스크롤의 y 위치
        
        if scrollView.contentOffset.y > 0 { print(#function, scrollView.contentOffset.y) }
        
        // 스크롤 정도에 따라 제목 글씨의 투명도가 변하도록 설정
        self.serviceHeaderView.tabTitleLabel.textColor = UIColor(
            white: 0.0,
            alpha: 1 - (scrollView.contentOffset.y/ServiceViewLayout.transparentTitleOffset)
        )
        
        // 스크롤한 정도에 따라 스택뷰의 top 제약조건이 변하도록 설정
        self.stackView.snp.updateConstraints {
            switch scrollView.contentOffset.y {
            case (ServiceViewLayout.stickyHeaderOffset...):
                $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-ServiceViewLayout.stickyHeaderOffset*0.6)
            case (0..<ServiceViewLayout.stickyHeaderOffset):
                $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-scrollView.contentOffset.y*0.6)
            case (..<0):
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
            default:
                break
            }
        }
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
