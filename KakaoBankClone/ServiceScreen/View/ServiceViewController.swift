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
    
    // 화면 최상단의 헤더뷰
    private let headerView: ServiceHeaderView = {
        let view = ServiceHeaderView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0
        return view
    }()
    
    // 탭 메뉴 컬렉션뷰
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        cv.register(
            ServiceMenuCollectionViewCell.self,
            forCellWithReuseIdentifier: ServiceMenuCollectionViewCell.identifier
        )
        cv.isScrollEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.collectionViewLayout = flowLayout
        cv.backgroundColor = UIColor(themeColor: .white)
        cv.layer.borderColor = UIColor.blue.cgColor
        cv.layer.borderWidth = 0
        cv.layer.masksToBounds = false
        cv.layer.shadowColor = UIColor(themeColor: .darkGray).cgColor
        cv.layer.shadowOpacity = 0.0
        cv.layer.shadowOffset = CGSize(width: 0, height: 2)
        cv.layer.shadowRadius = 2
        return cv
    }()
    
    // 탭 메뉴 하단의 강조 막대
    private let highlightBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(themeColor: .black)
        return view
    }()
    
    // 서비스 목록
    private let tableView: UITableView = {
        let tv = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .grouped)
        tv.register(
            ServiceTopAdTableViewCell.self,
            forCellReuseIdentifier: ServiceTopAdTableViewCell.identifier
        )
        tv.register(
            ServiceListTableViewCell.self,
            forCellReuseIdentifier: ServiceListTableViewCell.identifier
        )
        tv.showsVerticalScrollIndicator = false
        tv.separatorInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        tv.backgroundColor = UIColor(themeColor: .white)
        tv.layer.borderColor = UIColor.green.cgColor
        tv.layer.borderWidth = 0
        return tv
    }()
    
    //MARK: - 인스턴스
    
    // 뷰모델의 인스턴스
    private let viewModel = ServiceViewModel()
    
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
        self.view.addSubview(self.collectionView)
        self.collectionView.addSubview(self.highlightBar)
    }
    
    // 레이아웃 설정
    private func setupLayout() {
        // 테이블뷰
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.bottom.left.right.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        // 헤더뷰
        self.headerView.snp.makeConstraints {
            $0.top.equalTo(self.view)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceLayoutValues.headerMaxHeight)
        }
        
        // 메뉴 컬렉션뷰
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.headerView.snp.bottom)
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(ServiceLayoutValues.menuCollectionViewHeight)
        }
        
        self.tableView.contentOffset.y = -ServiceLayoutValues.headerMaxHeight  // 테이블뷰 스크롤의 초기 위치
        self.tableView.contentInset.top = ServiceLayoutValues.headerMaxHeight  // 테이블뷰 꼭대기의 내부간격
        
        // 강조 막대
        let minX = self.viewModel.sizeForheaderAndFooter.width + 7.5
        let maxX = minX + self.viewModel.sizeForItemAt(at: 0).width - 15
        
        self.highlightBar.snp.makeConstraints {
            $0.left.equalToSuperview().offset(minX)
            $0.right.equalToSuperview().offset(maxX)
            $0.top.equalTo(self.collectionView.snp.bottom).offset(33)
            $0.height.equalTo(2)
        }
    }
    
    // 대리자 설정
    private func setupDelegate() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    
        // 초기화 시 선택되어 있을 셀 지정하기
        self.collectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
    }
    
}

//MARK: - 컬렉션뷰 델리게이트 메서드

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSectionsInCollectionView
    }
    
    // section 내 아이템의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSections
    }
    
    // 각 아이템마다 실행할 내용
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceMenuCollectionViewCell.identifier, for: indexPath)
                as? ServiceMenuCollectionViewCell else { return UICollectionViewCell() }
        
        cell.serviceNameLabel.text = self.viewModel.titleForItemAt(at: indexPath.item)

        // 컬렉션뷰를 스크롤 하게 되면 셀이 재사용되면서 선택된 셀의 검정색 글자가 회색으로 변하는 현상 방지
        // (스크롤 해도 선택되어 있는 셀의 경우 항상 검정색 글자를 유지하고 그렇지 않은 경우 회색 글자를 유지하도록 설정)
        cell.serviceNameLabel.textColor = UIColor(white: cell.isSelected ? 0.0 : 0.5, alpha: 1)
        
        return cell
    }
    
    // 아이템이 선택되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // frame은 컬렉션뷰 내부 좌표계에 대한 값을 가지므로 frame 속성을 이용해 minX, maxX에 접근하면 안된다.
        // 따라서 컬렉션뷰의 좌표계로 변환하고 여기서의 minX, maxX를 구해야 한다.
        guard let selectedCell = self.collectionView.cellForItem(at: indexPath) else { return }
        let minX = selectedCell.convert(selectedCell.bounds, to: collectionView).minX + 7.5
        let maxX = selectedCell.convert(selectedCell.bounds, to: collectionView).maxX - 7.5
        
        UIView.animate(withDuration: 0.3) {
            // 컬렉션뷰의 스크롤을 최대한 화면 중앙으로 이동시키기
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            // 메뉴 하단의 강조 막대 움직이기
            self.highlightBar.snp.updateConstraints {
                $0.left.equalToSuperview().offset(minX)
                $0.right.equalToSuperview().offset(maxX)
            }
            // 하위뷰의 레이아웃 즉시 업데이트
            self.collectionView.layoutIfNeeded()
        }
        
        // 테이블뷰 스크롤을 특정 위치로 이동시키기
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.item), at: .top, animated: true)
        
        // 햅틱 반응
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        // 선택된 셀의 텍스트 색상을 검정색으로 변경 (dequeueReusableCell 메서드를 이용하면 안됨)
        guard let cell = collectionView.cellForItem(at: indexPath) as? ServiceMenuCollectionViewCell else { return }
        self.viewModel.changeCellUI(cell: cell, isSelected: true)
    }
    
    // 아이템이 해제되었을 때 실행할 내용
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 선택되지 않은 셀의 텍스트 색상을 회색으로 변경 (dequeueReusableCell 메서드를 이용하면 안됨)
        guard let cell = collectionView.cellForItem(at: indexPath) as? ServiceMenuCollectionViewCell else { return }
        self.viewModel.changeCellUI(cell: cell, isSelected: false)
    }
    
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.viewModel.sizeForheaderAndFooter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.viewModel.sizeForheaderAndFooter
    }
    
    // 각 셀의 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.viewModel.sizeForItemAt(at: indexPath.item)
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
            cell.setCellUI(
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
        // 이 조건문이 없으면 컬렉션뷰를 스크롤 할 때에도 이 델리게이트 메서드가 실행되므로 주의!
        guard scrollView == self.tableView else { return }
        
        // 현재 테이블뷰의 스크롤의 위치
        let currentOffset: CGFloat = -scrollView.contentOffset.y
        // 다이내믹한 오토레이아웃 설정을 위한 스크롤뷰 오프셋의 최소 기준값
        let minimum: CGFloat = ServiceLayoutValues.headerMinHeight + ServiceLayoutValues.topSafeAreaHeight
        // 다이내믹한 오토레이아웃 설정을 위한 스크롤뷰 오프셋의 최대 기준값
        let maximum: CGFloat = ServiceLayoutValues.headerMaxHeight + ServiceLayoutValues.topSafeAreaHeight
        // 현재 제목의 투명도
        let currentTitleAlpha = 1 - ((maximum - currentOffset) / (maximum - minimum))
        
        // 스크롤 정도에 따라 제목 글씨의 투명도가 변하도록 설정
        self.headerView.tabTitleLabel.textColor = UIColor(white: 0.0, alpha: currentTitleAlpha)
        
        // 스크롤 정도에 따라 투명도와 오토레이아웃이 변하도록 설정
        // 1) 헤더뷰 높이가 최대값으로 유지되는 구간
        if currentOffset >= maximum {
            //print("1) 헤더뷰 높이가 최대값으로 유지되는 구간")
            self.headerView.alpha = 1
            self.collectionView.alpha = 1
            self.collectionView.layer.shadowOpacity = 0
            self.headerView.snp.updateConstraints {
                $0.height.equalTo(ServiceLayoutValues.headerMaxHeight)
            }
        }
        // 2) 헤더뷰 높이가 변하는 구간
        else if currentOffset < maximum && currentOffset >= minimum {
            //print("2) 헤더뷰 높이가 변하는 구간")
            self.headerView.alpha = 1
            self.collectionView.alpha = 1
            self.collectionView.layer.shadowOpacity = 0
            self.headerView.snp.updateConstraints {
                $0.height.equalTo(currentOffset-ServiceLayoutValues.topSafeAreaHeight)
            }
        }
        // 3) 헤더뷰 높이가 최소값으로 유지되는 구간
        else {
            //print("3) 헤더뷰 높이가 최소값으로 유지되는 구간")
            self.headerView.alpha = 0.98
            self.collectionView.alpha = 0.98
            self.collectionView.layer.shadowOpacity = 0.1
            self.headerView.snp.updateConstraints {
                $0.height.equalTo(ServiceLayoutValues.headerMinHeight)
            }
        }
        
        print(currentOffset)
        
        // 스크롤 정도에 따라 메뉴 컬렉션뷰의 selected item이 달라지도록 설정
//        if currentOffset < -200 {
//            self.serviceMenuCollectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .centeredHorizontally)
//        }
    }
    
}
