//
//  Utils.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 13/02/2021.
//

import Foundation
import UIKit

struct Utils {
    
    static func getIconName(iconCode: String) -> String {
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
    
    static func getTemperatureValue(temperature: Double) -> String {
        if (temperature > -1 && temperature < 1) {
            return "0°C"
        } else {
            return String(format: "%.0f°C", temperature)
        }
    }
    
}

