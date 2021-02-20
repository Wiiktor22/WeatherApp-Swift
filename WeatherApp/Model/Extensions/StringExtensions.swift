//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 20/02/2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
