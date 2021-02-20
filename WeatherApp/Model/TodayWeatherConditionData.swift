//
//  TodayWeatherConditionData.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 19/02/2021.
//

import Foundation

struct TodayWeatherConditionData: Codable {
    var feelsLikeTemp: Double
    var pressure: Int
    var humidity: Int
    var windSpeed: Double
    var windDegree: String
    var sunTime: Date
    var lastLabelText: String
}
