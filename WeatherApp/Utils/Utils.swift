//
//  Utils.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 13/02/2021.
//

import Foundation
import UIKit

func getIconName(iconCode: String) -> String {
    switch(iconCode){
    case _ where iconCode.hasPrefix("03") || iconCode.hasPrefix("04"):
        return "03d"
    case _ where iconCode.hasPrefix("09"):
        return "09d"
    case _ where iconCode.hasPrefix("13"):
        return "13d"
    case _ where iconCode.hasPrefix("50"):
        return "50d"
    default:
        return iconCode
    }
}

extension UIColor{
    convenience init(hex: String, alpha: CGFloat) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init()
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
