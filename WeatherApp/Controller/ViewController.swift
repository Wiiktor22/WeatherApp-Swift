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
    @IBOutlet weak var sunLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerInstance.delegate = self
        
        if locationManagerInstance.authorizationStatus == .authorizedWhenInUse {
            locationManagerInstance.requestLocation()
        } else if locationManagerInstance.authorizationStatus == .denied {
            loadWeatherFromUserLocationCity()
        } else {
            locationManagerInstance.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        sunLogo.rotate()
    }
    
    // MARK: - Location logic
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (manager.authorizationStatus == .authorizedWhenInUse) {
            locationManagerInstance.requestLocation()
        } else {
            loadWeatherFromUserLocationCity()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            loadWeatherData(lat: lat, lon: lon)
        } else {
            Alert.presentDownloadingErrorAlert(on: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if (manager.authorizationStatus == .denied) {
            loadWeatherFromUserLocationCity()
        }
    }
    
    func loadWeatherFromUserLocationCity() {
        let savedLocation = WeatherData.lookForSavedUserLocation()
        if !savedLocation.isEmpty {
            let location = savedLocation.first
            loadWeatherData(lat: location?.lat ?? 0, lon: location?.lon ?? 0)
        } else {
            Alert.presentOpenLocationSettingsAlert(on: self)
        }
    }
    
    @IBAction func unwindToLoadView(_ sender: UIStoryboardSegue) {}
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Load weather logic
    
    func loadWeatherData(lat: Double, lon: Double, cityName: String? = nil) {
        NetworkService.request(router: .getAllWeatherDataByCoordinates(lat: lat, lon: lon)) { (result: WeatherData) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
                if let currentWeatherData = result.current {
                    if (cityName != nil) {
                        vc.cityAndCountryText = cityName!
                    } else {
                        CityName.getCityName(lat: lat, lon: lon) { (result: String) in
                            vc.cityAndCountryText = result
                        }
                    }
                    
                    vc.todayWeatherConditionData = TodayWeatherConditionData.prepareDataFromResponse(currentWeatherData)
                    vc.selectedLocation = Geocoding(name: nil, lat: lat, lon: lon, country: nil)
                    
                    if let weatherDescription = currentWeatherData.weather {
                        if let description = weatherDescription[0]!.description {
                            vc.weatherDescriptionText = description.capitalizingFirstLetter()
                        } else {
                            vc.weatherDescriptionText = "Brak opisu"
                        }
                        
                        if let iconCode = weatherDescription[0]?.icon {
                            vc.iconCode = Utils.getIconName(iconCode: iconCode)
                        } else {
                            vc.iconCode = "01d"
                        }
                    } else {
                        Alert.presentDownloadingErrorAlert(on: self)
                    }
                    
                    if let actualTemperatute = currentWeatherData.temp {
                        vc.actualTemperatureText = Utils.getTemperatureValue(temperature: actualTemperatute)
                    } else {
                        vc.actualTemperatureText = "-- °C"
                    }
                }
                
                if let dailyWeatherData = result.daily {
                    if let minTemperature = dailyWeatherData[0]?.temp?.min, let maxTemperature = dailyWeatherData[0]?.temp?.max {
                        vc.minTemperatureText = Utils.getTemperatureValue(temperature: minTemperature)
                        vc.maxTemperatureText = Utils.getTemperatureValue(temperature: maxTemperature)
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
                Alert.presentDownloadingErrorAlert(on: self)
            }
        }
    }
}
