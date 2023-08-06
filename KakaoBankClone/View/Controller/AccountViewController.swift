//
//  ViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import SnapKit

final class AccountViewController: UIViewController {

    //MARK: - UI 속성
    
    // 계좌 테이블뷰
    private let accountTableView: UITableView = {
        let tv = UITableView()
        tv.register(AccountTopAdTableViewCell.self, forCellReuseIdentifier: CellIdentifier.accountTopAd.rawValue)
        tv.register(AccountTableViewCell.self, forCellReuseIdentifier: CellIdentifier.account.rawValue)
        tv.register(AccountWithoutSafeBoxTableViewCell.self, forCellReuseIdentifier: CellIdentifier.accountWithoutSafeBox.rawValue)
        tv.register(AccountAddTableViewCell.self, forCellReuseIdentifier: CellIdentifier.accountAdd.rawValue)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        return tv
    }()
    
    // 새로고침
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.backgroundColor = UIColor.white
        control.tintColor = UIColor.black
        control.addTarget(self, action: #selector(refreshTableView(refresh:)), for: .valueChanged)
        return control
    }()
    
    //MARK: - 인스턴스
    
    // 뷰모델의 인스턴스
    private let viewModel = AccountViewModel()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupNavigationBar()
        self.setupView()
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
            title: NavigationBarTitle.account.rawValue,
            color: UIColor(themeColor: .black)
        )
        let button = self.navigationItem.makeSettingButton(
            title: self.viewModel.myAccountButtonName
        )
        let image = self.navigationItem.makeProfileImage(
            image: self.viewModel.myProfileImage
        )
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 5
        
        self.navigationItem.leftBarButtonItems = [title, spacer, button]
        self.navigationItem.rightBarButtonItems = [image]
    }
    
    // 뷰 설정
    private func setupView() {
        self.view.backgroundColor = UIColor(themeColor: .white)
    }
    
    // 테이블뷰 설정
    private func setupTableView() {
        // 뷰 등록 및 오토레이아웃 설정
        self.view.addSubview(self.accountTableView)
        self.accountTableView.snp.makeConstraints {
            $0.left.equalTo(self.view.safeAreaLayoutGuide)
            $0.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 대리자 지정
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
        
        // 하위뷰로 새로고침 등록
        self.accountTableView.addSubview(self.refreshControl)
    }
    
    // 새로고침 설정
    @objc private func refreshTableView(refresh: UIRefreshControl) {
        self.accountTableView.refreshControl = self.refreshControl
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.accountTableView.reloadData()
            refresh.endRefreshing()
        }

    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    // section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    // header의 높이
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.headerHeight
    }
    
    // footer의 높이
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.viewModel.footerHeight(at: section)
    }
    
    // footer view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.viewForFooterInSection(at: section)
    }
    
    // row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(at: section)
    }
    
    // row의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let accountData = self.viewModel.accountData[indexPath.row]
        return self.viewModel.cellHeight(at: indexPath.section, safeBox: accountData.hasSafeBox)
    }
    
    // 셀에 표출할 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.accountTopAd.rawValue, for: indexPath)
                    as? AccountTopAdTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setAd(
                title: self.viewModel.accountTopAdData[0].title,
                subtitle: self.viewModel.accountTopAdData[0].subtitle,
                image: self.viewModel.accountTopAdData[0].image
            )
            return cell
            
        case 1:
            let accountData = self.viewModel.accountData[indexPath.row]
            
            if accountData.hasSafeBox {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.account.rawValue, for: indexPath)
                        as? AccountTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.setAccount(
                    backgroundColor: accountData.backgroundColor,
                    tintColor: accountData.tintColor,
                    name: indexPath.row == 0 ? accountData.name + " ★" : accountData.name,
                    account: accountData.accountBalance.commaSeparatedWon,
                    safeBox: accountData.safeBoxBalance.commaSeparatedWon
                )
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.accountWithoutSafeBox.rawValue, for: indexPath)
                        as? AccountWithoutSafeBoxTableViewCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.setAccount(
                    backgroundColor: accountData.backgroundColor,
                    tintColor: accountData.tintColor,
                    name: indexPath.row == 0 ? accountData.name + " ★" : accountData.name,
                    account: accountData.accountBalance.commaSeparatedWon
                )
                return cell
            }
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.accountAdd.rawValue, for: indexPath)
                    as? AccountAddTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // 셀이 선택 되었을때 수행할 내용
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("광고 페이지로 이동합니다.")
            
        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.account.rawValue, for: indexPath) as? AccountTableViewCell,
//                  let touchPoint = tableView.indexPathForSelectedRow
//            else { fatalError() }
            
            // 특정 셀의 클릭된 지점(좌표) 가져오기
            if let cell = tableView.cellForRow(at: indexPath) {
                // 클릭된 지점은 tableView에서의 좌표이므로, 셀 내부의 좌표로 변환해야 합니다.
                let touchPoint = tableView.convert(tableView.contentOffset, to: cell)
                print("Section \(indexPath.section), Row \(indexPath.row) 클릭된 지점(좌표): \(touchPoint)")
            }
            
//            // 셀에서 계좌 영역을 눌렀을 때
//            if touchLocation.y < cellFrame.size.height / 2 {
//                cell.accountAreaTapped()
//            }
//            // 셀에서 세이프박스 영역을 눌렀을 때
//            else {
//                cell.safeBoxAreaTapped()
//            }
            
        case 2:
            print("계좌를 추가합니다.")
            
        default:
            break
        }
    }
    
}
