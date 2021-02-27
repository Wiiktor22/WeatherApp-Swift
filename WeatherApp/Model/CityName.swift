//
//  CityName.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 26/02/2021.
//

import Foundation

struct CityName: Codable {
    var name: String?
    var country: String?
    
    static func getCityName<T: Codable>(lat: Double, lon: Double, completion: @escaping (T) -> ()) {
        NetworkService.request(router: .getCityNameByCoordinates(lat: lat, lon: lon)) { (result: [CityName]) in
            var cityLabelText = ""
            
            if let cityName = result[0].name {
                cityLabelText = cityName
            }
            
            if let countryName = result[0].country {
                if cityLabelText.count == 0 {
                    cityLabelText = countryName
                } else {
                    cityLabelText = "\(cityLabelText), \(countryName)"
                }
            }
            
            DispatchQueue.main.async {
                completion(cityLabelText as! T)
            }
        }
    }
}
