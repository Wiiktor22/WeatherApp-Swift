//
//  HourlyWeatherData.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 19/02/2021.
//

import Foundation

struct HourlyWeatherData: Codable {
    var temp: Double
    var iconCode: String
    var hour: Int
    
    init(temp: Double, iconCode: String, hour: Int) {
        self.temp = temp
        self.iconCode = iconCode
        self.hour = hour
    }
}
