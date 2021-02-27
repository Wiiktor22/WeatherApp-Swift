//
//  Router.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 23/01/2021.
//

import Foundation

enum Router {
    
    case getAllWeatherDataByCoordinates(lat: Double, lon: Double)
    case getCityNameByCoordinates(lat: Double, lon: Double)
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.openweathermap.org"
    }
    
    var path: String {
        let defaultStartOfPath = "/data/2.5"
        switch self {
        case .getAllWeatherDataByCoordinates:
            return defaultStartOfPath + "/onecall"
        case .getCityNameByCoordinates:
            return "/geo/1.0/reverse"
        }
    }
    
    var parameters: [URLQueryItem] {
        let defaultParameters: [URLQueryItem] = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "pl")
        ]
        switch self {
        case .getAllWeatherDataByCoordinates(let lat, let lon):
            return defaultParameters + [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "exclude", value: "minutely")
            ]
        case .getCityNameByCoordinates(let lat, let lon):
            return [
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "limit", value: String(1)),
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon))
            ]
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var apiKey: String {
        return "a9da7325011280d0b734b6fe5b78703e"
    }
    
}
