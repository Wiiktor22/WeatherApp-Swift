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
        weatherCondition = createArrayOfWeatherConditionValues(todayWeatherConditionData)

        collectionView.delegate = self
        collectionView.dataSource = self
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
        let minuteString = minute < 10 ? "0\(minute)" : String(minute)

        weatherConditionTitles.append(weatherCondition.lastLabelText)
        
        return [
            getTemperatureValue(temperature: weatherCondition.feelsLikeTemp),
            "\(weatherCondition.pressure) hPa",
            "\(weatherCondition.humidity)%",
            String(format: "%.0f km/h", weatherCondition.windSpeed),
            weatherCondition.windDegree,
            "\(hour):\(minuteString)"
        ]
    }

}
