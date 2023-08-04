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
    
    private let accountTableView: UITableView = {
        let tv = UITableView()
        //tv.backgroundColor = UIColor.white
        tv.register(AccountTopAdTableViewCell.self, forCellReuseIdentifier: CellIdentifier.accountTopAd.rawValue)
        tv.register(AccountTableViewCell.self, forCellReuseIdentifier: CellIdentifier.account.rawValue)
        tv.register(AccountAddTableViewCell.self, forCellReuseIdentifier: CellIdentifier.accountAdd.rawValue)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        return tv
    }()
    
    //MARK: - 인스턴스
    
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
        
        // 내 계좌 버튼 설정
        let title = self.navigationItem.makeTitle(title: NavigationBarTitle.account.rawValue, color: UIColor.black)
        let button = self.navigationItem.makeSettingButton(title: "내 계좌")
        let image = self.navigationItem.makeProfileImage(image: UIImage(named: "flower")!)
        let spacer1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let spacer2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer1.width = 20
        spacer2.width = 5
        
        self.navigationItem.leftBarButtonItems = [title, spacer2, button]
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
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 대리자 지정
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
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
        return section == 2 ? self.viewModel.footerHeight : 0
    }
    
    // footer view
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return section == 2 ? UIView() : nil
    }
    
    // row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(at: section)
    }
    
    // row의 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.cellHeight(at: indexPath.section)
    }
    
    // 셀에 표출할 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.accountTopAd.rawValue, for: indexPath)
                    as? AccountTopAdTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setAd(
                title: "뜨거운 여름, 쿨한 혜택!",
                subtitle: "최대 6만원 혜택 챙기기",
                image: UIImage(named: "krw-money")!
            )
            return cell
        }
        
        else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.accountAdd.rawValue, for: indexPath)
                    as? AccountAddTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.account.rawValue, for: indexPath)
                    as? AccountTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setContainerViewColor(color: UIColor(themeColor: ThemeColor(rawValue: 3)!))
            cell.setBalance(
                account: Int.random(in: 0...100_000),
                safeBox: Int.random(in: 0...1_000_000)
            )
            return cell
        }
    }
    
    // 셀이 선택 되었을때 수행할 내용
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            print("계좌를 추가합니다.")
        }
    }
    
}
