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
    
    // RGB 값 대신 HexCode를 입력했을 때 UIColor를 지정할 수 있도록 지원하는 편의생성자
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(themeColor: ThemeColor) {
        switch themeColor {
        case .transparentBlack:
            self.init(hexCode: "#000000", alpha: 0.05)
        case .black:
            self.init(hexCode: "#1E1E1E", alpha: 1.0)
        case .white:
            self.init(hexCode: "#FFFFFF", alpha: 1.0)
        case .lightGray:
            self.init(hexCode: "#F7F7F6", alpha: 1.0)
        case .pink:
            self.init(hexCode: "#DE5A79", alpha: 1.0)
        case .yellow:
            self.init(hexCode: "#FCE002", alpha: 1.0)
        case .green:
            self.init(hexCode: "#4DB964", alpha: 1.0)
        case .blue:
            self.init(hexCode: "#0B84D8", alpha: 1.0)
        }
    }
    
}
