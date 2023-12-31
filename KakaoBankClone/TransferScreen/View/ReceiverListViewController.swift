//
//  TransferViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/15.
//

import UIKit
import SnapKit

final class ReceiverListViewController: UIViewController {
    
    //MARK: - UI 속성
    
    // 화면 상단의 헤더뷰
    private let headerView: ReceiverListHeaderView = {
        let view = ReceiverListHeaderView()
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        view.layer.shadowOpacity = 0.0
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    // 화면 최상단의 네비게이션 뷰
    private let navigationView: ReceiverListNavigationView = {
        let view = ReceiverListNavigationView()
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 0
        return view
    }()
    
    // 계좌 테이블뷰
    private let accountListTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(
            ReceiverListTableViewCell.self,
            forCellReuseIdentifier: ReceiverListTableViewCell.identifier
        )
        tv.backgroundColor = UIColor(themeColor: .white)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.layer.borderColor = UIColor.red.cgColor
        tv.layer.borderWidth = 0
        return tv
    }()
    
    // 계좌번호 직접입력 버튼
    let accountNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle(ButtonTitle.enterAccount.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        button.backgroundColor = UIColor(themeColor: .white)
        button.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 5
        button.layer.cornerRadius = 10
        //button.clipsToBounds = true
        return button
    }()
    
    // 로딩 표시
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        ai.stopAnimating()
        ai.style = .large
        return ai
    }()
    
    //MARK: - 뷰모델의 인스턴스 및 생성자
    
    private var viewModel: ReceiverListViewModel
    
    init(viewModel: ReceiverListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 인스턴스 및 기타 속성
    
    // 계좌 데이터
    private var db = [ReceiverListModel]()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firestore에서 DB를 가져오기 전에 실행할 내용
        self.setupView()
        
        // Firestore에서 DB를 가져온 후에 실행할 내용
        self.viewModel.fetchReceiverAccountDataFromServer() { db in
            // 로그인한 사용자의 계좌는 이체 받을사람 목록에서 제외하기
            self.db = db.filter { $0.receiverAccountNumber != self.viewModel.accountNumber }
                
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
        self.view.addSubview(self.accountListTableView)
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.navigationView)
        self.view.addSubview(self.accountNumberButton)
        self.view.addSubview(self.activityIndicator)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 테이블뷰
        self.accountListTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 테이블뷰 꼭대기의 내부간격
        self.accountListTableView.contentInset.top = TransferLayoutValues.receiverListNavigationViewHeight
        
        // 헤더뷰
        self.headerView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(TransferLayoutValues.headerMaxHeight)
        }
        
        // 네비게이션 뷰
        self.navigationView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(TransferLayoutValues.receiverListNavigationViewHeight)
        }
        
        // 계좌번호 직접입력 버튼
        self.accountNumberButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            $0.left.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            $0.height.equalTo(60)
        }
        
        // 로딩 표시
        self.activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.navigationView.delegate = self
        
        self.accountListTableView.delegate = self
        self.accountListTableView.dataSource = self
    }

}

//MARK: - 네비게이션 뷰에 대한 커스텀 델리게이트 메서드

extension ReceiverListViewController: ReceiverListNavigationViewDelegate {
    
    func closeButtonTapped() {
        // 화면 빠져나오기
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - 테이블뷰 델리게이트 메서드

extension ReceiverListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.db.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewModel.viewForHeaderInSection(tableView: tableView, at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return self.viewModel.viewForFooterInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.db[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReceiverListTableViewCell.identifier, for: indexPath)
                as? ReceiverListTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.applyCellUI(
            type: BankType(rawValue: data.receiverBankName) ?? .kakao,
            name: data.receiverName,
            number: data.receiverAccountNumber
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 로딩 애니메이션 시작
        self.activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            // 다음 화면으로 데이터를 전달하고 넘어가기
            let nextVM = TransferInfoViewModel(  // 다음 화면의 뷰모델
                userName: self.viewModel.userName,
                accountName: self.viewModel.accountName,
                accountNumber: self.viewModel.accountNumber,
                currentBalance: self.viewModel.currentBalance,
                selectedReceiverBankName: self.db[indexPath.row].receiverBankName,
                selectedReceiverID: self.db[indexPath.row].receiverID,
                selectedReceiverName: self.db[indexPath.row].receiverName,
                selectedReceiverAccount: self.db[indexPath.row].receiverAccountNumber,
                selectedReceiverAccountBalance: self.db[indexPath.row].receiverAccountBalance
            )
            let nextVC = TransferInfoViewController(viewModel: nextVM)  // 다음 화면의 뷰컨트롤러
            self.navigationController?.pushViewController(nextVC, animated: true)
            
            // 로딩 애니메이션 종료
            self.activityIndicator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

    }
    
}
