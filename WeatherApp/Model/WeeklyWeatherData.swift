//
//  WeeklyWeatherData.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 23/02/2021.
//

import Foundation

struct WeeklyTemperatureData {
    var temp: String
    var iconCode: String
    
    static func prepareDataFromResponse(_ weatherWeeklyData: [DailyWeatherTempObject]) -> [WeeklyTemperatureData] {
        let slicedWeatherWeeklyData = weatherWeeklyData[1...7]
        
        return slicedWeatherWeeklyData.map { unit in
            if let dailyTemperature = unit.temp?.day, let dailyTemperatureIcon = unit.weather?[0]?.icon {
                return WeeklyTemperatureData(temp: getTemperatureValue(temperature: dailyTemperature), iconCode: dailyTemperatureIcon)
            } else {
                return WeeklyTemperatureData(temp: "0", iconCode: "0")
            }
        }
    }
    
    static func prepareNamesOfDaysArray() -> [String] {
        var names = [String]()
        let day = Calendar.current.component(.weekday, from: Date())
        
        for i in 0...6 {
            var numberOfTheDay = day + i + 1
            if numberOfTheDay > 7 {
                numberOfTheDay -= 7
            }
            names.append(getNameOfTheDay(numberOfTheDay))
        }
        
        return names
    }
    
    private static func getNameOfTheDay(_ day: Int) -> String {
        switch day {
        case 1:
            return "Niedziela"
        case 2:
            return "Poniedziałek"
        case 3:
            return "Wtorek"
        case 4:
            return "Środa"
        case 5:
            return "Czwartek"
        case 6:
            return "Piątek"
        case 7:
            return "Sobota"
        default:
            return "Error"
        }
    }
}
