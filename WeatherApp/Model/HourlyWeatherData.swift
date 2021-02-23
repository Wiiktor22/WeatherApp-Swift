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
    
    static func prepareDataFromResponse(_ hourlyWeatherData: [CurrentWeatherObject]) -> [HourlyWeatherData] {
        let slicedHourlyWeatherArray = sliceHourlyWeatherDataArray(hourlyWeatherData)
        
        let currentTime = Date()
        let nextHour = Calendar.current.component(.hour, from: currentTime) + 1
        
        return slicedHourlyWeatherArray.enumerated().map { (index, hourlyWeather) -> HourlyWeatherData in
            if let unitTemp = hourlyWeather.temp, let unitIconCode = hourlyWeather.weather?[0]?.icon {
                return HourlyWeatherData(temp: unitTemp, iconCode: unitIconCode, hour: nextHour + index)
            } else {
                return HourlyWeatherData(temp: 0, iconCode: "01d", hour: 0)
            }
        }
    }
    
    private static func sliceHourlyWeatherDataArray(_ hourlyWeatherData: [CurrentWeatherObject]) -> [CurrentWeatherObject] {
        if (hourlyWeatherData.count >= 24) {
            let slicedHourlyWeatherData = Array(hourlyWeatherData[1...23])
            return slicedHourlyWeatherData
        } else {
            return hourlyWeatherData
        }
    }
}
