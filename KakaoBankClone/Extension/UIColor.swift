//
//  UIColor.swift
//  KakaoBankClone
//
//  Created by Eric on 2023/08/03.
//

import UIKit

extension UIColor {
    
    // RGB 값을 n/255가 아닌 n으로 입력해도 UIColor를 지정할 수 있도록 지원하는 편의생성자
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
    
    // RGB 값을 16진법으로 입력해도 UIColor를 지정할 수 있도록 지원하는 편의생성자
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(themeColor: ThemeColor) {
        switch themeColor {
        case .yellow:
            self.init(
                red: 250.0 / 255.0,
                green: 227.0 / 255.0,
                blue: 76.0 / 255.0,
                alpha: 1.0
            )
        case .lightGray:
            self.init(
                red: 246.0 / 255.0,
                green: 246.0 / 255.0,
                blue: 246.0 / 255.0,
                alpha: 1.0
            )
        case .black:
            self.init(
                red: 40.0 / 255.0,
                green: 42.0 / 255.0,
                blue: 48.0 / 255.0,
                alpha: 1.0
            )
        case .white:
            self.init(
                red: 255.0 / 255.0,
                green: 255.0 / 255.0,
                blue: 255.0 / 255.0,
                alpha: 1.0
            )
        }
    }
    
}
