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
    
    // TODO: Try to refactor some parts of the code to pure function
    
    func loadWeatherData() {
        NetworkService.request(router: .getAllWeatherDataByCoordinates(lat: 54.5189, lon: 18.5319)) {
            (result: WeatherData) in
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController {
                if let currentWeatherData = result.current {
                    // TODO: Set proper name and date??
                    vc.cityAndCountryText = "Gdynia, Polska"
                    vc.todayWeatherConditionData = self.prepareTodayWeatherConditionData(currentWeatherData)
                    
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
                    vc.weeklyTemperatureData = self.prepareWeeklyTemperatureData(convertedDailyWeatherData)
                }
                
                if let optionalHourlyWeatherData = result.hourly {
                    let hourlyWeatherData = optionalHourlyWeatherData.compactMap { $0 }
                    vc.hourlyWeatherData = self.prepareHourlyWeatherDataForSubview(hourlyWeatherData)
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                // TODO: Handle error related to downloading data
                print("Error while downloading data :(")
            }
        }
    }
    
    func prepareHourlyWeatherDataForSubview(_ hourlyWeatherData: [CurrentWeatherObject]) -> [HourlyWeatherData] {
        let slicedHourlyWeatherArray = sliceHourlyWeatherDataArray(hourlyWeatherData)
        
        let currentTime = Date()
        let nextHour = Calendar.current.component(.hour, from: currentTime) + 1
        
        return slicedHourlyWeatherArray.enumerated().map { (index, hourlyWeather) -> HourlyWeatherData in
            if let unitTemp = hourlyWeather.temp, let unitIconCode = hourlyWeather.weather?[0]?.icon {
                return HourlyWeatherData(temp: unitTemp, iconCode: unitIconCode, hour: nextHour + index)
            } else {
                return HourlyWeatherData(temp: 0, iconCode: "01d", hour: 0)
            }
        }
    }
    
    func sliceHourlyWeatherDataArray(_ hourlyWeatherData: [CurrentWeatherObject]) -> [CurrentWeatherObject] {
        if (hourlyWeatherData.count >= 24) {
            let slicedHourlyWeatherData = Array(hourlyWeatherData[1...23])
            return slicedHourlyWeatherData
        } else {
            return hourlyWeatherData
        }
    }
    
    func prepareTodayWeatherConditionData(_ weatherConditionData: CurrentWeatherObject) -> TodayWeatherConditionData {
        let currentTime = Date()
        var sunTime: Date? = nil
        var lastLabelText: String! = nil
        
        if let sunrise = weatherConditionData.sunrise, let sunset = weatherConditionData.sunset {
            let convertedSunrise = Date(timeIntervalSince1970: TimeInterval(sunrise))
            let convertedSunset = Date(timeIntervalSince1970: TimeInterval(sunset))
            
            if (currentTime > convertedSunrise && currentTime < convertedSunset) {
                sunTime = convertedSunset
                lastLabelText = "zachód"
            } else {
                sunTime = convertedSunrise
                lastLabelText = "wschód"
            }
        }
        
        return TodayWeatherConditionData(
            feelsLikeTemp: weatherConditionData.feels_like ?? 0,
            pressure: weatherConditionData.pressure ?? 0,
            humidity: weatherConditionData.humidity ?? 0,
            windSpeed: weatherConditionData.wind_speed ?? 0,
            windDegree: getWindDirection(weatherConditionData.wind_deg ?? 0),
            sunTime: sunTime ?? Date(),
            lastLabelText: lastLabelText
        )
    }
    
    func prepareWeeklyTemperatureData(_ weatherWeeklyData: [DailyWeatherTempObject]) -> [WeeklyTemperatureData] {
        let slicedWeatherWeeklyData = weatherWeeklyData[1...7]
        
        return slicedWeatherWeeklyData.map { unit in
            if let dailyTemperature = unit.temp?.day, let dailyTemperatureIcon = unit.weather?[0]?.icon {
                return WeeklyTemperatureData(temp: getTemperatureValue(temperature: dailyTemperature), iconCode: dailyTemperatureIcon)
            } else {
                return WeeklyTemperatureData(temp: "0", iconCode: "0")
            }
        }
    }
}
