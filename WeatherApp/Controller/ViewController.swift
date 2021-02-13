//
//  ViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 06/01/2021.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeatherData()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
    }
    
    func loadWeatherData() {
        NetworkService.request(router: .getAllWeatherDataByCoordinates(lat: 54.5189, lon: 18.5319)) {
            (result: WeatherData) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
                if let currentWeatherData = result.current {
                    // TODO: Set proper name and date??
                    vc.cityAndCountryText = "Gdynia, Polska"
                    
                    if let weatherDescription = currentWeatherData.weather {
                        if let description = weatherDescription[0]!.description {
                            vc.weatherDescriptionText = description.capitalizingFirstLetter()
                        } else {
                            vc.weatherDescriptionText = "Brak opisu"
                        }
                        
                        // TODO: Icon!
                    } else {
                        print("There is no weatherDescription object...")
                    }
                    
                    if let actualTemperatute = currentWeatherData.temp {
                        let formattedActualWeather = String(format: "%.0f°C", actualTemperatute)
                        vc.actualTemperatureText = formattedActualWeather
                    } else {
                        vc.actualTemperatureText = "-- °C"
                    }
                    
                }
                
                if let dailyWeatherData = result.daily {
                    if let minTemperature = dailyWeatherData[0]?.temp?.min, let maxTemperature = dailyWeatherData[0]?.temp?.max {
                        let formattedMinTemperature = String(format: "Min: %.0f °C", minTemperature)
                        let formattedMaxTemperature = String(format: "Max: %.0f °C", maxTemperature)
                        print("Temperature")
                        print(formattedMaxTemperature)
                        print(formattedMinTemperature)
                        vc.minTemperatureText = formattedMinTemperature
                        vc.maxTemperatureText = formattedMaxTemperature
                    } else {
                        vc.maxTemperatureText = "-- °C"
                        vc.maxTemperatureText = "-- °C"
                        print("Yep error")
                    }
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                // TODO: Handle error related to downloading data
                print("Error while downloading data :(")
            }
        }
    }
}

// TODO: Place this extension in proper way
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

