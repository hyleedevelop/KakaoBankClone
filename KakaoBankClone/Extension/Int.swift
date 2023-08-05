//
//  Int.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/05.
//

import Foundation

extension Int {
    
    var commaSeparatedWon: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else {
            return String(self)
        }
        
        return "\(formattedNumber)원"
    }
    
}
