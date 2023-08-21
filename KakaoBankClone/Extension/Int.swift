//
//  Int.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/05.
//

import Foundation

extension Int {
    
    // 정수 값을 콤마로 3자리씩 구분지어서 문자열로 표현하기
    var commaSeparatedWon: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        
        return "\(formattedNumber)"
    }
    
    // 정수 값을 한국식 숫자세기를 이용해 문자열로 표현하기
    var koreanStyleWon: String {
        let tenThousand: Int = 10_000
        let hundredMillion: Int = 100_000_000
        
        let aboveHundredMillion = self / hundredMillion
        let aboveTenThousand = self / tenThousand
        let belowTenThousand = self % tenThousand

        // 1만원 미만인 경우
        if self < tenThousand {
            return "\(belowTenThousand.commaSeparatedWon)"
        }
        // 1억원 미만인 경우
        else if self >= tenThousand && self < hundredMillion {
            if self % tenThousand == 0 {
                return "\(aboveTenThousand.commaSeparatedWon)만"
            } else {
                return "\(aboveTenThousand.commaSeparatedWon)만 \(belowTenThousand.commaSeparatedWon)"
            }
        }
        // 1억원 이상인 경우
        else {
            if self % hundredMillion == 0 {
                return "\(aboveHundredMillion.commaSeparatedWon)억"
            } else {
                if (aboveTenThousand % tenThousand == 0) && (self % tenThousand == 0) {
                    return "\(aboveHundredMillion.commaSeparatedWon)억 " +
                    "\((aboveTenThousand % tenThousand).commaSeparatedWon)만"
                } else if (aboveTenThousand % tenThousand == 0) && (self % tenThousand != 0) {
                    return "\(aboveHundredMillion.commaSeparatedWon)억 " +
                    "\(belowTenThousand.commaSeparatedWon)"
                } else {
                    return "\(aboveHundredMillion.commaSeparatedWon)억 " +
                    "\((aboveTenThousand % tenThousand).commaSeparatedWon)만 " +
                    "\(belowTenThousand.commaSeparatedWon)"
                }
            }
        }
    }
    
}
