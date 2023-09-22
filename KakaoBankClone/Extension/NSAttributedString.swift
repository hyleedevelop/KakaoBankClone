//
//  NSAttributedString.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/07.
//

import UIKit

extension NSAttributedString {
    
    // 레이블에서 텍스트를 여러 줄에 나눠서 나타낼 때 사용
    func withLineSpacing(spacing: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: string.count)
        )
        return NSAttributedString(attributedString: attributedString)
    }
    
}
