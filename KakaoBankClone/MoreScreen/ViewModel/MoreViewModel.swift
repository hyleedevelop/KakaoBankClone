//
//  MoreMenuViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

final class MoreViewModel {
    
    //MARK: - 생성자
    
    init() {
        self.moreListData = [[
            MoreListModel(title: "26주적금with선물하기럭스", badge: .none),
            MoreListModel(title: "혜택 좋은 신용카드", badge: .new),
            MoreListModel(title: "배지 모으기", badge: .new),
            MoreListModel(title: "편리해진 모임통장, 더 잘 쓰는 법", badge: .up),
        ], [
            MoreListModel(title: "매일 용돈받기", badge: .none),
            MoreListModel(title: "내 혜택", badge: .none),
        ], [
            MoreListModel(title: "내 신용정보", badge: .none),
            MoreListModel(title: "내 계좌", badge: .none),
            MoreListModel(title: "내 문서함", badge: .none),
            MoreListModel(title: "개인금고", badge: .none),
        ], [
            MoreListModel(title: "이체", badge: .none),
            MoreListModel(title: "다건이체", badge: .none),
            MoreListModel(title: "자동이체", badge: .none),
            MoreListModel(title: "이체내역 조회", badge: .none),
            MoreListModel(title: "ATM 스마트출금", badge: .none),
        ], [
            MoreListModel(title: "돈이 되는 이야기", badge: .event),
            MoreListModel(title: "세금/공과금 납부", badge: .none),
            MoreListModel(title: "휴면예금/보험금 찾기", badge: .none),
        ], [
            MoreListModel(title: "내 카드", badge: .none),
            MoreListModel(title: "이번달 카드 실적", badge: .none),
            MoreListModel(title: "프렌즈 체크카드", badge: .none),
            MoreListModel(title: "프렌즈 캐시백 프로모션", badge: .none),
            MoreListModel(title: "카드 청구금액 알림", badge: .none),
        ], [
            MoreListModel(title: "해외송금 보내기", badge: .none),
            MoreListModel(title: "해외송금 받기", badge: .none),
            MoreListModel(title: "해외송금 내역조회", badge: .none),
            MoreListModel(title: "거래외국환은행 지정", badge: .none),
        ], [
            MoreListModel(title: "국내주식 투자", badge: .none),
            MoreListModel(title: "해외주식 투자", badge: .none),
            MoreListModel(title: "약속한 수익 받기", badge: .none),
            MoreListModel(title: "증권사 주식계좌", badge: .none),
        ], [
            MoreListModel(title: "신용대출 갈아타기", badge: .none),
            MoreListModel(title: "비상금대출", badge: .none),
            MoreListModel(title: "마이너스 통장대출", badge: .none),
            MoreListModel(title: "신용대출/중신용대출", badge: .none),
            MoreListModel(title: "전월세보증금 대출", badge: .up),
            MoreListModel(title: "주택담보대출", badge: .none),
        ], [
            MoreListModel(title: "개인사업자 신용대출 이자 반값", badge: .event),
            MoreListModel(title: "개인사업자통장", badge: .none),
            MoreListModel(title: "개인사업자 신용대출", badge: .none),
            MoreListModel(title: "개인사업자 보증서대출", badge: .none),
            MoreListModel(title: "개인사업자 체크카드", badge: .none),
            MoreListModel(title: "개인사업자 제휴 신용카드", badge: .up),
            MoreListModel(title: "종합소득세/부가가치세 조회하기", badge: .none),
        ], [
            MoreListModel(title: "카카오뱅크 mini", badge: .none),
            MoreListModel(title: "내 mini카드", badge: .none),
            MoreListModel(title: "mini 26일저금", badge: .none),
        ], [
            MoreListModel(title: "우리학교 급식표/시간표", badge: .none),
        ], [
            MoreListModel(title: "입출금통장", badge: .none),
            MoreListModel(title: "모임통장", badge: .none),
            MoreListModel(title: "세이프박스", badge: .none),
            MoreListModel(title: "저금통", badge: .none),
            MoreListModel(title: "기록통장", badge: .none),
            MoreListModel(title: "26주적금", badge: .none),
            MoreListModel(title: "자유적금", badge: .none),
            MoreListModel(title: "정기예금", badge: .none),
        ]]
        
        self.firstSectionHeaderTitle = [
            "", "혜택", "MY", "이체/출금", "생활/편의",
            "카드", "해외송금", "투자", "대출", "사업자",
            "mini", "mini 생활", "예적금"
        ]
    }
    
    //MARK: - 데이터 관련
    
    // 메뉴 리스트 데이터
    private var moreListData: [[MoreListModel]]
    
    // 1번째 섹션의 헤더 제목
    private var firstSectionHeaderTitle: [String]
    
    //MARK: - 테이블뷰
    
    // section의 개수
    var numberOfSections: Int {
        return 1 + self.moreListData.count + 1  // 상단 광고 1개 + 메뉴 목록 + 하단 광고 1개
    }
    
    // section당 row의 개수
    func numberOfRowsInSection(at section: Int) -> Int {
        if section == 0 || section == self.numberOfSections - 1 { return 1 }
        else { return self.moreListData[section-1].count }
    }
    
    // header 높이
    func heightForHeaderInSection(at section: Int) -> CGFloat {
        if section <= 1 || section == self.numberOfSections - 1 { return 0 }
        else { return 45 }
    }
    
    // footer 높이
    func heightForFooterInSection(at section: Int) -> CGFloat {
        //if section == 0 || section == self.numberOfSections - 1 { return 0 }
        //else { return 10 }
        return 30
    }
    
    // cell 높이
    func heightForRow(at section: Int) -> CGFloat {
        if section == 0 { return 150 }
        else if section == self.numberOfSections - 1 { return 100 }
        else { return 52 }
    }
    
    // custom header view
    func viewForHeaderInSection(tableView: UITableView, at section: Int) -> UIView? {
        // 첫번째, 두번째와 마지막을 제외한 나머지 섹션에만 헤더뷰 넣기
        guard (section >= 2) && (section != self.numberOfSections - 1) else { return nil }
        
        let titleLabel = UILabel(
            frame: CGRect(x: 25, y: 15, width: tableView.frame.width, height: 45)
        )
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        titleLabel.textColor = UIColor(themeColor: .darkGray)
        titleLabel.text = self.firstSectionHeaderTitle[section-1]

        let headerView = UIView()
        headerView.addSubview(titleLabel)
        headerView.backgroundColor = UIColor(themeColor: .white)
        headerView.layer.borderColor = UIColor.cyan.cgColor
        headerView.layer.borderWidth = 0
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(25)
            $0.centerY.equalToSuperview()
        }

        return headerView
    }

    // custom footer view
    func viewForFooterInSection(tableView: UITableView, at section: Int) -> UIView? {
        // 마지막에서 2번째와 1번째를 제외한 나머지 섹션에만 푸터뷰 넣기
        guard section < self.numberOfSections - 2 else { return nil }
        
        let separatorView = UIView(frame: CGRect(
            x: 20, y: 15, width: tableView.frame.width - 40, height: 1
        ))
        separatorView.backgroundColor = UIColor.systemGray5
        
        let footerView = UIView()
        footerView.addSubview(separatorView)
        
        return footerView
    }

    // 더보기 메뉴 목록 가져오기
    func getMoreListData(at indexPath: IndexPath) -> MoreListModel {
        return self.moreListData[indexPath.section-1][indexPath.row]
    }
    
}
