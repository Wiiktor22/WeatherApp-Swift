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
    
    // TODO: Try to refactor some parts of the code
    
    func loadWeatherData() {
        NetworkService.request(router: .getAllWeatherDataByCoordinates(lat: 54.5189, lon: 18.5319)) { (result: WeatherData) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
                if let currentWeatherData = result.current {
                    // TODO: Set proper name and date??
                    vc.cityAndCountryText = "Gdynia, Polska"
                    vc.todayWeatherConditionData = TodayWeatherConditionData.prepareDataFromResponse(currentWeatherData)
                    
                    if let weatherDescription = currentWeatherData.weather {
                        if let description = weatherDescription[0]!.description {
                            vc.weatherDescriptionText = description.capitalizingFirstLetter()
                        } else {
                            vc.weatherDescriptionText = "Brak opisu"
                        }
                        
                        if let iconCode = weatherDescription[0]?.icon {
                            vc.iconCode = getIconName(iconCode: iconCode)
                        } else {
                            vc.iconCode = "01d"
                        }
                    } else {
                        print("There is no weatherDescription object...")
                    }
                    
                    if let actualTemperatute = currentWeatherData.temp {
                        vc.actualTemperatureText = getTemperatureValue(temperature: actualTemperatute)
                    } else {
                        vc.actualTemperatureText = "-- °C"
                    }
                    
                }
                
                if let dailyWeatherData = result.daily {
                    if let minTemperature = dailyWeatherData[0]?.temp?.min, let maxTemperature = dailyWeatherData[0]?.temp?.max {
                        vc.minTemperatureText = getTemperatureValue(temperature: minTemperature)
                        vc.maxTemperatureText = getTemperatureValue(temperature: maxTemperature)
                    } else {
                        vc.maxTemperatureText = "-- °C"
                        vc.maxTemperatureText = "-- °C"
                    }
                    
                    let convertedDailyWeatherData = dailyWeatherData.compactMap { $0 }
                    vc.weeklyTemperatureData = WeeklyTemperatureData.prepareDataFromResponse(convertedDailyWeatherData)
                }
                
                if let optionalHourlyWeatherData = result.hourly {
                    let hourlyWeatherData = optionalHourlyWeatherData.compactMap { $0 }
                    vc.hourlyWeatherData = HourlyWeatherData.prepareDataFromResponse(hourlyWeatherData)
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                // TODO: Handle error related to downloading data
                print("Error while downloading data :(")
            }
        }
    }
}
