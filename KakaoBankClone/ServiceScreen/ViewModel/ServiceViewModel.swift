//
//  ServiceMenuViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit
import SnapKit

final class ServiceViewModel {
    
    //MARK: - 생성자
    
    init() {
        // 상단 광고 컬렉션뷰에서 무한 스크롤 구현을 위해 앞과 뒤에 데이터를 추가 -> () 표시된 부분
        // 기존: 1 - 2 - 3
        // 변경: (3) - 1 - 2 - 3 - (1)
        self.serviceTopAdData.insert(self.serviceTopAdData[self.serviceTopAdData.count-1], at: 0)
        self.serviceTopAdData.append(self.serviceTopAdData[1])
    }
    
    //MARK: - 데이터 관련
    
    private var serviceTopAdData: [ServiceTopAdModel] = [
        ServiceTopAdModel(
            backgroundColor: UIColor(themeColor: .blue),
            title: "쉐보레, 더 뉴 트레일블레이저",
            subtitle: NSAttributedString(string: "견적 상담하고\n미국 여행권 등\n선물 받아가세요").withLineSpacing(3),
            image: UIImage(systemName: "car.side.fill")!
        ),
        ServiceTopAdModel(
            backgroundColor: UIColor(themeColor: .green),
            title: "유병자를 위한 보험",
            subtitle: NSAttributedString(string: "삼성화재 다이렉트\nSmart 유병자\n간편보험").withLineSpacing(3),
            image: UIImage(systemName: "stethoscope")!
        ),
        ServiceTopAdModel(
            backgroundColor: UIColor(themeColor: .yellow),
            title: "돈이 되는 꿀팁",
            subtitle: NSAttributedString(string: "돌아온 휴가 시즌\n기차 30% 할인\n받는 방법은?").withLineSpacing(3),
            image: UIImage(systemName: "train.side.rear.car")!
        ),
    ]
    
    let serviceListData: [[ServiceListModel]] = [[
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "입출금통장",
            subtitle: "까다로운 계좌개설도 손쉽게", hasInterest: true, interest: "연 0.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "모임통장",
            subtitle: "함께쓰고 같이봐요", hasInterest: true, interest: "연 0.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "세이프박스",
            subtitle: "여유자금을 따로 보관하세요", hasInterest: true, interest: "연 2.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "저금통",
            subtitle: "매일매일 조금씩 쌓여요", hasInterest: true, interest: "연 10.00%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "정기예금",
            subtitle: "실시간 이자가 쌓여요", hasInterest: true, interest: "연 3.50%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "자유적금",
            subtitle: "매일/매주/매월 자유롭게", hasInterest: true, interest: "연 4.00%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green),title: "기록통장",
            subtitle: "최애적금으로 세상처음 돈버는 덕질", hasInterest: true, interest: "연 2.00%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "26주적금",
            subtitle: "캐릭터와 함께 즐거운 도전", hasInterest: true, interest: "연 7.00%"
        ),
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "프렌즈 체크카드",
            subtitle: "쓸 때마다 캐시백, 주말엔 2배", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "제휴 신용카드",
            subtitle: "신청은 간편하게 혜택은 다양하게", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "카드 청구금액 알림",
            subtitle: "결제일 별로 청구금액과 계좌 잔액을 한눈에", hasInterest: false, interest: nil
        ),
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .blue), title: "비상금대출",
            subtitle: "현금 필요할 때 유용하게", hasInterest: true, interest: "연 4.69%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .blue), title: "마이너스 통장대출",
            subtitle: "이자는 사용한 만큼만", hasInterest: true, interest: "연 5.44%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .blue), title: "신용대출/중신용대출",
            subtitle: "목돈이 필요할 땐 쉽고 빠르게", hasInterest: true, interest: "연 4.44%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .blue), title: "전월세보증금 대출",
            subtitle: "어떤 집이든, 꼭 맞는 전세대출을", hasInterest: true, interest: "연 3.40%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .blue), title: "주택담보대출",
            subtitle: "낮은 금리로 연립, 다세대까지", hasInterest: true, interest: "연 3.97%"
        ),
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "개인금고",
            subtitle: "이제 정보도 돈처럼 은행에 맡기세요", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "내 신용정보",
            subtitle: "내 신용정보를 안전하고 간편하게", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "신용대출 갈아타기",
            subtitle: "빠르고 간편한 대출 갈아타기", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "해외송금 보내기",
            subtitle: "해외계좌송금과 WU빠른해외송금", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "해외송금 받기",
            subtitle: "지점방문 없이 간편하게", hasInterest: false, interest: nil
        ),
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "국내주식 투자",
            subtitle: "한국투자증권에서 제공하는 국내주식 거래 서비스", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "해외주식 투자",
            subtitle: "한국투자증권에서 제공하는 미니스탁 서비스", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "약속한 수익 받기",
            subtitle: "한국투자증권에서 제공하는 금융상품투자 서비스", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "증권사 주식계좌",
            subtitle: "간편하게 개설하는 증권사 계좌", hasInterest: false, interest: nil
        ),
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "카카오뱅크 mini",
            subtitle: "10대부터 만들고 용돈을 편하게", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "mini카드",
            subtitle: "결제도 ATM도 교통비도 카드 하나로", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "mini 26일저금",
            subtitle: "매일매일 차곡차곡", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "우리학교 급식표/시간표",
            subtitle: "mini 생활, 학교생활 필수정보", hasInterest: false, interest: nil
        ),
    ], [
        ServiceListModel(
            tintColor: UIColor(themeColor: .green), title: "개인사업자통장",
            subtitle: "사장님의 사업 운영을 쉽고, 빠르게", hasInterest: true, interest: "연 0.10%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .blue), title: "개인사업자 신용대출",
            subtitle: "바쁜 사장님을 위한 간편한 신용대출", hasInterest: true, interest: "연 4.30%"
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "개인사업자 보증서대출",
            subtitle: "보증기관 방문없이 편리한 보증서대출", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "개인사업자 체크카드",
            subtitle: "사업자에게 꼭 필요한 혜택만 담아", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "개인사업자 제휴 신용카드",
            subtitle: "기본할인부터 사업자 특화혜택까지", hasInterest: false, interest: nil
        ),
        ServiceListModel(
            tintColor: UIColor(themeColor: .black), title: "종합소득세/부가가치세 조회하기",
            subtitle: "사업자를 위한 쉽고 빠른 세금신고", hasInterest: false, interest: nil
        ),
    ]]
    
    let categoryName: [String] = ["전체", "예적금", "카드", "대출", "서비스", "투자", "mini", "사업자"]
    
    // 뷰컨트롤러와 뷰모델의 데이터 사이의 연결고리
    var getTopAdData: [ServiceTopAdModel] {
        return self.serviceTopAdData
    }
    
    //MARK: - 테이블뷰 관련
    
    // section의 개수
    lazy var numberOfSections: Int = 1 + self.serviceListData.count
    
    // section당 row의 개수
    func numberOfRowsInSection(at section: Int) -> Int {
        return section == 0 ? 1 : self.serviceListData[section-1].count
    }
    
    // header 높이
    func headerHeight(at section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }
    
    // footer 높이
    func footerHeight(at section: Int) -> CGFloat {
        return section == 0 ? 50 : 150
    }
    
    // cell 높이
    func cellHeight(at section: Int) -> CGFloat {
        return section == 0 ? 290 : 85
    }
    
    // custom header view
    func viewForHeaderInSection(tableView: UITableView, at section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let titleLabel = UILabel(
                frame: CGRect(x: 25, y: 0, width: tableView.frame.width, height: 22)
            )
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            titleLabel.textColor = UIColor.black
            titleLabel.text = self.categoryName[section]

            let headerView = UIView()
            headerView.addSubview(titleLabel)
            headerView.layer.borderColor = UIColor.cyan.cgColor
            headerView.layer.borderWidth = 0

            return headerView
        }
    }
    
    // custom footer view
    func viewForFooterInSection(at section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let containerView = UIView()
            containerView.backgroundColor = UIColor(themeColor: .pink)
            containerView.layer.cornerRadius = 15
            containerView.clipsToBounds = true
            
            let footerView = UIView()
            footerView.addSubview(containerView)
            footerView.layer.borderColor = UIColor.orange.cgColor
            footerView.layer.borderWidth = 0
            containerView.snp.makeConstraints {
                $0.left.equalToSuperview().offset(20)
                $0.right.equalToSuperview().offset(-20)
                $0.top.equalToSuperview().offset(20)
                $0.height.equalTo(55)
            }
            
            return footerView
        }
    }
 
    //MARK: - 컬렉션뷰 관련

    // section의 개수
    let numberOfSectionsInCollectionView: Int = 1
    
    // item의 개수
    lazy var numberOfItemsInSections: Int = self.categoryName.count
    
    // item의 셀 높이
    func sizeForItemAt(at item: Int) -> CGSize {
        let labelWidth = self.calculateLabelWidth(for: self.categoryName[item])
        let cellWidth = labelWidth + 10  // Adding 10 for left and right spacing
        return CGSize(width: cellWidth, height: ServiceLayoutValues.menuCollectionViewHeight - 10)
    }
    
    // 컬렉션뷰 셀에 들어가는 레이블의 넓이 계산
    func calculateLabelWidth(for text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }

    // item의 메뉴 제목
    func titleForItemAt(at item: Int) -> String {
        return self.categoryName[item]
    }
    
    // header와 footer의 크기
    var sizeForheaderAndFooter: CGSize {
        return CGSize(width: 20, height: ServiceLayoutValues.menuCollectionViewHeight)
    }
    
    // 셀의 선택/해제 여부에 따른 UI 변경
    func changeCellUI(cell: ServiceMenuCollectionViewCell, isSelected: Bool) {
        DispatchQueue.main.async {
            cell.serviceNameLabel.textColor = UIColor(white: isSelected ? 0.0 : 0.5, alpha: 1)
        }
    }
    
}
