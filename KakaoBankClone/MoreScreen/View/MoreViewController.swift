//
//  MoreMenuViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class MoreViewController: UIViewController {

    //MARK: - UI 속성
    
    // 화면 최상단의 헤더뷰
    private let headerView: MoreHeaderView = {
        let view = MoreHeaderView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        view.layer.shadowOpacity = 0.0
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    // 더보기 목록
    private let tableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(
            MoreListTableViewCell.self,
            forCellReuseIdentifier: MoreListTableViewCell.identifier
        )
        tv.register(
            MoreTopAdTableViewCell.self,
            forCellReuseIdentifier: MoreTopAdTableViewCell.identifier
        )
        tv.register(
            MoreBottomAdTableViewCell.self,
            forCellReuseIdentifier: MoreBottomAdTableViewCell.identifier
        )
        tv.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        tv.backgroundColor = UIColor(themeColor: .white)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        //tv.layer.borderColor = UIColor.red.cgColor
        //tv.layer.borderWidth = 1
        return tv
    }()
    
    //MARK: - 인스턴스
    
    // 뷰모델의 인스턴스
    private let viewModel = MoreViewModel()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupView()
        self.addSubview()
        self.setupLayout()
        self.setupDelegate()
    }

    //MARK: - 메서드
    
    // 뷰 설정
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 하위 뷰 추가
    private func addSubview() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.headerView)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 헤더뷰
        self.headerView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceLayoutValues.headerMaxHeight)
        }
        self.headerView.setTitle(title: UserDefaults.standard.userName)
        
        // 테이블뷰
        self.tableView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.headerView.snp.bottom)
        }
        
        self.tableView.contentInset.top = 0  // 테이블뷰 꼭대기의 내부간격
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

//MARK: - 테이블뷰 델리게이트 메서드

extension MoreViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        return self.viewModel.heightForRow(at: indexPath.section)
    }
    
    // header의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.heightForHeaderInSection(at: section)
    }
    
    // footer의 높이
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewModel.heightForFooterInSection(at: section)
    }
    
    // header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewModel.viewForHeaderInSection(tableView: tableView, at: section)
    }
    
    // footer view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.viewForFooterInSection(tableView: tableView, at: section)
    }
    
    // 셀에 표출할 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:  // 0번째 section: 상단 광고 컬렉션뷰
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreTopAdTableViewCell.identifier, for: indexPath)
                    as? MoreTopAdTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.setCellUI(
                image: UIImage(named: "krw-money")!,
                title: "재단 방문 없이 보증서대출 신청하기"
            )
            
            return cell

        case self.viewModel.numberOfSections-1:  // 마지막 section: 하단 광고 컬렉션뷰
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreBottomAdTableViewCell.identifier, for: indexPath)
                    as? MoreBottomAdTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            //cell.setAd(model: self.viewModel.getTopAdData)
            
            return cell
            
        default:  // 나머지 section: 더보기 메뉴 목록 테이블뷰
            let data = self.viewModel.getMoreListData(at: indexPath)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreListTableViewCell.identifier, for: indexPath)
                    as? MoreListTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.accessoryType = .disclosureIndicator
            cell.setCellUI(title: data.title, badge: data.badge)
            
            return cell
        }
    }
    
    // 셀이 선택 되었을때 수행할 내용
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // 테이블뷰의 스크롤이 완료되었을 때 수행할 내용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 이 조건문이 없으면 컬렉션뷰를 스크롤 할 때에도 이 델리게이트 메서드가 실행되므로 주의!
        guard scrollView == self.tableView else { return }
        
        // 현재 테이블뷰의 스크롤의 위치
        let currentOffset: CGFloat = -scrollView.contentOffset.y
        // 스크롤뷰 오프셋의 기준값
        let thresholdOffset: CGFloat = 0
        
        // 스크롤 정도에 따라 투명도와 오토레이아웃이 변하도록 설정
        if currentOffset >= thresholdOffset {
            self.headerView.alpha = 1
            self.headerView.layer.shadowOpacity = 0
        }
        else {
            self.headerView.alpha = 0.98
            self.headerView.layer.shadowOpacity = 0.1
        }
        
        //print(currentOffset)
    }
    
}
