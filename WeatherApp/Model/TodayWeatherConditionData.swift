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
    
    private static func getWindDirection(_ windDegree: Int) -> String {
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
    
    static func prepareDataFromResponse(_ weatherConditionData: CurrentWeatherObject) -> TodayWeatherConditionData {
        let currentTime = Date()
        var sunTime: Date? = nil
        var lastLabelText: String! = nil
        
        if let sunrise = weatherConditionData.sunrise, let sunset = weatherConditionData.sunset {
            let convertedSunrise = Date(timeIntervalSince1970: TimeInterval(sunrise))
            let convertedSunset = Date(timeIntervalSince1970: TimeInterval(sunset))
            
            if (currentTime > convertedSunrise && currentTime < convertedSunset) {
                sunTime = convertedSunset
                lastLabelText = "zachód"
            } else {
                sunTime = convertedSunrise
                lastLabelText = "wschód"
            }
        }
        
        return TodayWeatherConditionData(
            feelsLikeTemp: weatherConditionData.feels_like ?? 0,
            pressure: weatherConditionData.pressure ?? 0,
            humidity: weatherConditionData.humidity ?? 0,
            windSpeed: weatherConditionData.wind_speed ?? 0,
            windDegree: getWindDirection(weatherConditionData.wind_deg ?? 0),
            sunTime: sunTime ?? Date(),
            lastLabelText: lastLabelText
        )
    }
}
