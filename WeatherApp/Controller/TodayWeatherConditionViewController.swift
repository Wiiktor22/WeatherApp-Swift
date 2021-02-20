//
//  TodayWeatherConditionViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 16/01/2021.
//

import UIKit

class TodayWeatherConditionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherConditionTitles = ["odczuwalna", "ciśnienie", "wilgotność", "wiatr", "kierunek"]
    var todayWeatherConditionData: TodayWeatherConditionData! = nil
    var weatherCondition = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherConditionTitles.append(addLastWeatherConditionTitle())
        weatherCondition = createArrayOfWeatherConditionValues(todayWeatherConditionData)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func addLastWeatherConditionTitle() -> String{
        let now = Date()
        let hour = Calendar.current.component(.hour, from: now)
        //let minute = Calendar.current.component(.minute, from: now)
        
        // TODO: Set true time, to define which title should be right now
        
        if hour > 17 || hour < 7 {
            return "zachód"
        } else {
            return "wschód"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherConditionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCondition", for: indexPath) as! TodayWeatherConditionCell
        
        cell.titleCondition.text = weatherConditionTitles[indexPath.item]
        cell.weatherValueCondition.text = weatherCondition[indexPath.item]
        
        return cell
    }
    
    func createArrayOfWeatherConditionValues(_ weatherCondition: TodayWeatherConditionData) -> [String] {
        let hour = Calendar.current.component(.hour, from: weatherCondition.sunTime)
        let minute = Calendar.current.component(.minute, from: weatherCondition.sunTime)
        
        return [
            getTemperatureValue(temperature: weatherCondition.feelsLikeTemp),
            "\(weatherCondition.pressure) hPa",
            "\(weatherCondition.humidity)%",
            "\(weatherCondition.windSpeed) km/h",
            weatherCondition.windDegree,
            "\(hour):\(minute)"
        ]
    }

}
