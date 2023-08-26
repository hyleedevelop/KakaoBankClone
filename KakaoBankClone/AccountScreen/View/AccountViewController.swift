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
    
    // 화면 최상단의 헤더뷰
    private let headerView: AccountHeaderView = {
        let view = AccountHeaderView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        view.layer.shadowOpacity = 0.0
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    // 계좌 테이블뷰
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(
            AccountTopAdTableViewCell.self,
            forCellReuseIdentifier: AccountTopAdTableViewCell.identifier
        )
        tv.register(
            AccountTableViewCell.self,
            forCellReuseIdentifier: AccountTableViewCell.identifier
        )
        tv.register(
            AccountWithoutSafeBoxTableViewCell.self,
            forCellReuseIdentifier: AccountWithoutSafeBoxTableViewCell.identifier
        )
        tv.register(
            AccountAddTableViewCell.self,
            forCellReuseIdentifier: AccountAddTableViewCell.identifier
        )
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
    
    // 로딩 표시 애니메이션이 작동중일 때 나머지 배경을 어둡게 하는 디밍뷰
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .black)
        view.alpha = 0.0
        return view
    }()
    
    // 로딩 표시
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.stopAnimating()
        ai.style = .large
        return ai
    }()
    
    //MARK: - 인스턴스 및 기타 속성
    
    // 뷰모델의 인스턴스
    private let viewModel = AccountViewModel()
    
    // 계좌 데이터
    private var db = [AccountModel]()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firestore에서 DB를 가져오기 전에 실행할 내용
        self.setupView()
        
        // Firestore에서 DB를 가져온 후에 실행할 내용
        self.viewModel.fetchAccountDataFromServer(userID: UserDefaults.standard.userID) { db in
            self.db = db
                
            self.addSubview()
            self.setupLayout()
            self.setupDelegate()
        }
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
        self.view.addSubview(self.activityIndicator)
        self.tableView.addSubview(self.refreshControl)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 헤더뷰
        self.headerView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceLayoutValues.headerMaxHeight)
        }
        
        self.headerView.setTitle(title: self.viewModel.getUserName(userID: UserDefaults.standard.userID))
        
        // 로딩 표시
        self.activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 테이블뷰
        self.tableView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.headerView.snp.bottom)
        }

        self.tableView.contentInset.top = 10  // 테이블뷰 꼭대기의 내부간격
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - objc 메서드
    
    // 테이블뷰 새로고침 시 실행할 내용 설정
    @objc private func refreshTableView(refresh: UIRefreshControl) {
        // 로딩중 표시하기
        self.tableView.refreshControl = self.refreshControl
        
        // 테이블뷰 셀 애니메이션 비활성화
        UserDefaults.standard.showCellAnimation = false
        
        // 테이블뷰 갱신
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.tableView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    @objc private func buttonTapped(_ button: UIButton) {
        // 하위뷰 추가
        self.view.addSubview(self.dimmingView)
        
        // 초기 상태
        self.dimmingView.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(self.view)
        }
        self.dimmingView.alpha = 0.5
        
        // 로딩 애니메이션 시작
        self.activityIndicator.startAnimating()
        
        // 테이블뷰 셀 애니메이션 비활성화
        UserDefaults.standard.showCellAnimation = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // 로딩 애니메이션 종료
            self.activityIndicator.stopAnimating()
            self.dimmingView.alpha = 0.0
            
            // 화면 전환
            let nextVM = ReceiverListViewModel(  // 다음 화면의 뷰모델
                userName: self.viewModel.getUserName(userID: UserDefaults.standard.userID),
                accountName: self.viewModel.getAccountName(userID: UserDefaults.standard.userID),
                accountNumber: self.viewModel.getAccountNumber(userID: UserDefaults.standard.userID),
                currentBalance: self.viewModel.getAccountBalance(userID: UserDefaults.standard.userID)
            )
            let nextVC = ReceiverListViewController(viewModel: nextVM)  // 다음 화면의 뷰컨트롤러
            let nav = UINavigationController(rootViewController: nextVC)
            
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            nav.isModalInPresentation = true  // true이면 쓸어내리기 불가능
            
            self.present(nav, animated: true)
        }
    }
    
}

//MARK: - 테이블뷰 델리게이트 메서드

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
        return self.viewModel.cellHeight(
            at: indexPath.section,
            safeBox: self.viewModel.isAccountIncludeSafeBox(at: indexPath.row)
        )
    }
    
    // 셀에 표출할 내용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTopAdTableViewCell.identifier, for: indexPath)
                    as? AccountTopAdTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setAd(model: self.viewModel.getTopAdData)
            
            return cell

        case 1:
            let data = self.db[indexPath.row]

            // 계좌가 세이프박스를 포함하는 경우
            if data.hasSafeBox {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for: indexPath)
                        as? AccountTableViewCell else { return UITableViewCell() }

                cell.selectionStyle = .none
                cell.setAccount(
                    backgroundColor: data.backgroundColor,
                    tintColor: data.tintColor,
                    accountName: indexPath.row == 0 ? data.accountName + " ★" : data.accountName,
                    accountNumber: data.accountNumber,
                    accountBalance: data.accountBalance.commaSeparatedWon + "원",
                    safeBoxBalance: data.safeBoxBalance.commaSeparatedWon + "원"
                )
                cell.transferButton.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)
                cell.playTableViewCellAnimation(
                    sequence: indexPath.row,
                    startAnimation: UserDefaults.standard.showCellAnimation
                )

                return cell
            }
            
            // 계좌가 세이프박스를 포함하지 않는 경우
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountWithoutSafeBoxTableViewCell.identifier, for: indexPath)
                        as? AccountWithoutSafeBoxTableViewCell else { return UITableViewCell() }

                cell.selectionStyle = .none
                cell.setAccount(
                    backgroundColor: data.backgroundColor,
                    tintColor: data.tintColor,
                    accountName: indexPath.row == 0 ? data.accountName + " ★" : data.accountName,
                    safeBoxBalance: data.accountBalance.commaSeparatedWon + "원"
                )
                cell.playTableViewCellAnimation(
                    sequence: indexPath.row,
                    startAnimation: UserDefaults.standard.showCellAnimation
                )
                
                return cell
            }

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountAddTableViewCell.identifier, for: indexPath)
                    as? AccountAddTableViewCell else { return UITableViewCell() }

            cell.selectionStyle = .none
            cell.playTableViewCellAnimation(
                sequence: self.viewModel.numberOfAccountData + indexPath.row,
                startAnimation: UserDefaults.standard.showCellAnimation
            )
            
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
            // 특정 셀의 클릭된 지점(좌표) 가져오기
            if let cell = tableView.cellForRow(at: indexPath) {
                // 클릭된 지점은 tableView에서의 좌표이므로, 셀 내부의 좌표로 변환해야 합니다.
                let touchPoint = tableView.convert(tableView.contentOffset, to: cell)
                print("Section \(indexPath.section), Row \(indexPath.row) 클릭된 지점(좌표): \(touchPoint)")
            }

        case 2:
            print("계좌를 추가합니다.")

        default:
            break
        }
    }

    // 테이블뷰의 스크롤이 완료되었을 때 수행할 내용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 이 조건문이 없으면 컬렉션뷰를 스크롤 할 때에도 이 델리게이트 메서드가 실행되므로 주의!
        guard scrollView == self.tableView else { return }

        // 현재 테이블뷰의 스크롤의 위치
        let currentOffset: CGFloat = -scrollView.contentOffset.y
        // 스크롤뷰 오프셋의 기준값
        let thresholdOffset: CGFloat = 10

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
