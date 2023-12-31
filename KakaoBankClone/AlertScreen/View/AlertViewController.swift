//
//  AlertViewController.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class AlertViewController: UIViewController {
    
    //MARK: - UI 속성
    
    // 화면 최상단의 헤더뷰
    private let headerView: AlertHeaderView = {
        let view = AlertHeaderView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        view.layer.shadowOpacity = 0.0
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    // 알림 테이블뷰
    private let alertTableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(
            AlertTableViewCell.self,
            forCellReuseIdentifier: AlertTableViewCell.identifier
        )
        tv.backgroundColor = UIColor(themeColor: .white)
        tv.showsVerticalScrollIndicator = true
        tv.separatorStyle = .none
        return tv
    }()

    //MARK: - 인스턴스 및 기타 속성
    
    // 뷰모델의 인스턴스
    private let viewModel = AlertViewModel()
    
    //MARK: - 생명주기
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupView()
        
        // Firestore에서 DB를 가져온 후에 실행할 내용
        self.viewModel.fetchTransactionDataFromServer {
            self.addSubview()
            self.setupLayout()
            self.setupDelegate()
            
            self.viewModel.setupSnapshotListenerForAlertList {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    // 스냅샷 리스너를 통해 새로운 거래가 발생하면 알림 목록 갱신하기
                    self.alertTableView.reloadData()
                }
            }
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
        self.view.addSubview(self.alertTableView)
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
        
        // 테이블뷰
        self.alertTableView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(self.headerView.snp.bottom)
        }
        
        self.alertTableView.contentInset.top = 0  // 테이블뷰 꼭대기의 내부간격
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.alertTableView.delegate = self
        self.alertTableView.dataSource = self
    }

}

//MARK: - 테이블뷰 델리게이트 메서드

extension AlertViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.identifier, for: indexPath)
                as? AlertTableViewCell else { return UITableViewCell() }
 
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.setCellUI(
            image: self.viewModel.getAlertLogoImage(at: indexPath.row),
            title: self.viewModel.getAlertTitle(at: indexPath.row),
            content: self.viewModel.getAlertContent(at: indexPath.row),
            date: self.viewModel.getTransactionDate(at: indexPath.row)
        )
        
        return cell
    }
    
    // 테이블뷰의 스크롤이 완료되었을 때 수행할 내용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 이 조건문이 없으면 컬렉션뷰를 스크롤 할 때에도 이 델리게이트 메서드가 실행되므로 주의!
        guard scrollView == self.alertTableView else { return }
        
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
