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

func getWindDirection(_ windDegree: Int) -> String {
    if (windDegree ~= windDegree) {
        switch windDegree {
            case 23...66:
                return "NE"
            case 67...112:
                return "E"
            case 113...158:
                return "SE"
            case 159...204:
                return "S"
            case 205...250:
                return "SW"
            case 251...296:
                return "W"
            case 297...338:
                return "NW"
            default:
                return "N"
        }
    } else {
        return "Error"
    }
}

func getTemperatureValue(temperature: Double) -> String {
    if (temperature > -1 && temperature < 1) {
        return "0°C"
    } else {
        return String(format: "%.0f°C", temperature)
    }
}

