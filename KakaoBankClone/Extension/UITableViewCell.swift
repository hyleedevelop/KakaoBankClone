//
//  UITableViewCell.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/08.
//

import UIKit

extension UITableViewCell {
 
    func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
    
}
