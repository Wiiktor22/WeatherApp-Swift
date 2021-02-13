//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 01/02/2021.
//

import Foundation

struct WeatherData: Codable {
    var lat: Double?
    var lon: Double?
    var current: CurrentWeatherObject?
    var hourly: [CurrentWeatherObject?]?
    var daily: [DailyWeatherTempObject?]?
}

struct CurrentWeatherObject: Codable {
    var sunrise: Int?
    var sunset: Int?
    var temp: Double?
    var feels_like: Double?
    var pressure: Int?
    var humidity: Int?
    var clouds: Int?
    var visibility: Int?
    var wind_speed: Double?
    var wind_deg: Int?
    var weather: [WeatherDescriptionObject?]?
    var pop: Double?
}

struct WeatherDescriptionObject: Codable {
    var main: String?
    var description: String?
    var icon: String?
}

struct DailyWeatherObject: Codable {
    var sunrise: Int?
    var sunset: Int?
    
}

struct DailyWeatherTempObject: Codable {
    var temp: TempObjectInsideDailyWeather?
    var pressure: Int?
    var humidity: Int?
    var wind_speed: Double?
    var wind_deg: Int?
    var weather: [WeatherDescriptionObject?]?
    var clouds: Int?
    var pop: Double?
}

struct TempObjectInsideDailyWeather: Codable {
    var day: Double?
    var night: Double?
    var min: Double?
    var max: Double?
}
