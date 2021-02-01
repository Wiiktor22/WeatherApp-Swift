//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 30/01/2021.
//

import Foundation

struct CurrentWeather: Codable {
    var coord: CoordObject?
    var weather: [WeatherObject?]?
    var main: MainObject?
    var visibilty: Int?
    var wind: WindObject?
    var clouds: CloudsObject?
    var sys: SysObject?
    var name: String?
    var message: String?
}

struct CoordObject: Codable {
    var lon: Double?
    var lat: Double?
}

struct WeatherObject: Codable {
    var main: String?
    var description: String?
    var icon: String?
}

struct MainObject: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var humidity: Double?
}

struct WindObject: Codable {
    var speed: Double?
    var deg: Int?
}

struct CloudsObject: Codable {
    var all: Int?
}

struct SysObject: Codable {
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}
