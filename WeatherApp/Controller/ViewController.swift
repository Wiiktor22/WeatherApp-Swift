//
//  ViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 06/01/2021.
//

import UIKit
import CoreLocation

class LoadingViewController: UIViewController, CLLocationManagerDelegate {
    let locationManagerInstance = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerInstance.delegate = self
        
        if locationManagerInstance.authorizationStatus != .authorizedWhenInUse {
            locationManagerInstance.requestWhenInUseAuthorization()
        } else {
            locationManagerInstance.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (manager.authorizationStatus == .authorizedWhenInUse) {
            locationManagerInstance.requestLocation()
        } else {
            print("error")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            loadWeatherData(lat: lat, lon: lon)
        }
        
        // TODO: Define error?
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (manager.authorizationStatus == .notDetermined) {
            print("Dont know yet")
            return
        } else if (manager.authorizationStatus == .denied) {
            print("Denied")
            return
        }
    }
    
    @IBAction func unwindToLoadView(_ sender: UIStoryboardSegue) {}
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // TODO: Try to refactor some parts of the code, move this function away from this VC
    
    func loadWeatherData(lat: Double, lon: Double) {
        NetworkService.request(router: .getAllWeatherDataByCoordinates(lat: lat, lon: lon)) { (result: WeatherData) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
                if let currentWeatherData = result.current {
                    CityName.getCityName(lat: lat, lon: lon) { (result: String) in
                        vc.cityAndCountryText = result
                    }
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
