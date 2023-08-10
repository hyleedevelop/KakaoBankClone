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
        return view
    }()
    
    // 서비스 목록
    let serviceListTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(ServiceTopAdTableViewCell.self, forCellReuseIdentifier: ServiceTopAdTableViewCell.identifier)
        tv.register(ServiceListTableViewCell.self, forCellReuseIdentifier: ServiceListTableViewCell.identifier)
        tv.showsVerticalScrollIndicator = true
        tv.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        tv.backgroundColor = UIColor(themeColor: .white)
        tv.layer.borderColor = UIColor.blue.cgColor
        tv.layer.borderWidth = 0.5
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
        self.view.addSubview(self.serviceHeaderView)
        self.serviceHeaderView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceViewLayout.transparentTitleOffset)
        }
        
        self.serviceHeaderView.delegate = self
    }
    
    // 테이블뷰 설정
    private func setupTableView() {
        self.view.addSubview(self.serviceListTableView)
        self.serviceListTableView.snp.makeConstraints {
            $0.top.equalTo(self.serviceHeaderView.snp.bottom).offset(10)
            $0.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
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
            //cell.backgroundColor = UIColor.green
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
        // 현재 테이블뷰의 스크롤의 위치
        let currentOffset: CGFloat = scrollView.contentOffset.y
        // 헤더뷰가 고정되기 시작하는 스크롤의 위치
        let stickyOffset: CGFloat = ServiceViewLayout.stickyHeaderOffset
        // 타이틀이 완전히 투명해질 때 스크롤의 위치
        let transparentOffset: CGFloat = ServiceViewLayout.transparentTitleOffset
        
        //print(#function, currentOffset)
        
        // 스크롤 정도에 따라 제목 글씨의 투명도가 변하도록 설정
        self.serviceHeaderView.tabTitleLabel.textColor = UIColor(
            white: 0.0,
            alpha: 1 - (currentOffset/transparentOffset)
        )
        
        // 스크롤 정도에 따라 헤더뷰의 오토레이아웃이 변하도록 설정
        switch currentOffset {
        case (stickyOffset...):  // 스크롤 처음 상태보다 아래로 내림 + 타이틀이 완전히 사라진 구간
            self.serviceHeaderView.snp.updateConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-stickyOffset*0.6)
            }
        case (0..<stickyOffset):  // 스크롤 처음 상태보다 아래로 내림 + 타이틀이 희미해지는 구간
            self.serviceHeaderView.snp.updateConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(-currentOffset*0.6)
            }
            
        case (..<0):  // 스크롤 처음 상태보다 위로 올림
            self.serviceHeaderView.snp.updateConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
            }
        default:
            break
        }
    }
    
}

//MARK: - 헤더뷰에 대한 커스텀 델리게이트 메서드

extension ServiceViewController: ServiceHeaderViewDelegate {
    
    // 메뉴 컬렉션뷰의 아이템을 눌렀을 때 테이블뷰의 특정 section으로 이동하기
    func didSelectCollectionViewItem(at section: Int) {
        let indexPath = IndexPath(row: 0, section: section)
        self.serviceListTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}
