//
//  UITableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/08.
//

import UIKit

extension UITableViewCell {
 
    // section 구분선 제거
    func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
    
    // 셀 로딩 애니메이션
    func playTableViewCellAnimation(sequence: Int, startAnimation: Bool) {
        // true인 경우에만 애니메이션 시작
        guard startAnimation else { return }
        
        self.transform = CGAffineTransform(translationX: 0, y: 800)
        self.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(sequence),
            options: [.transitionCurlDown, .preferredFramesPerSecond60],
            animations: {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
                self.alpha = 1
            })
    }
    
    
}
