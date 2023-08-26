//
//  TransferCompleteViewModel.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/26.
//

import UIKit

final class TransferCompleteViewModel {
 
    //MARK: - 생성자
    
    init(selectedReceiverName: String, selectedReceiverAccount: String, amount: Int) {
        self.selectedReceiverName = selectedReceiverName
        self.selectedReceiverAccount = selectedReceiverAccount
        self.amount = amount
    }
    
    //MARK: - 계좌 정보 관련
    
    var selectedReceiverName: String
    var selectedReceiverAccount: String
    var amount: Int
    
}
