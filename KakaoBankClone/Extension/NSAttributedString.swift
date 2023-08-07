//
//  NSAttributedString.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/07.
//

import UIKit

extension NSAttributedString {
    
    // 레이블에서 여러 줄의 텍스트를 나타낼 때, 
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: string.count)
        )
        return NSAttributedString(attributedString: attributedString)
    }
    
}
