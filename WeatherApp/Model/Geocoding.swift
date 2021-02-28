//
//  Geocoding.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 28/02/2021.
//

import Foundation
import UIKit

struct Geocoding: Codable {
    var name: String?
    var lat: Double?
    var lon: Double?
    var country: String?
    
    static func getGeocodingObject<T: Codable>(city: String, completion: @escaping (T) -> ()) {
        NetworkService.request(router: .getCoordinatesByCityName(city: city)) { (result: [Geocoding]) in
            var geocodingObject: Geocoding? = nil
            if (!result.isEmpty) {
                geocodingObject = result[0]
            }
            
            DispatchQueue.main.async {
                completion(geocodingObject as! T)
            }
        }
    }
}
