//
//  UITabBar.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/04.
//

import UIKit

extension UITabBar {
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 120
        return sizeThatFits
    }
    
}
