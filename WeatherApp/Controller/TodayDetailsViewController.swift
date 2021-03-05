//
//  TodayDetailsViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 09/01/2021.
//

import UIKit

class TodayDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var hourlyWeatherData: [HourlyWeatherData]! = nil
    var todayWeatherConditionData: TodayWeatherConditionData! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeather", for: indexPath) as! HourlyWeatherCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor ?? UIColor(hex: "#d6d6d6", alpha: 1).cgColor
        cell.layer.shadowOpacity = 0.6
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 5
        
        let currentIterationData = hourlyWeatherData[indexPath.item]
        
        cell.weatherIcon.image = UIImage(named: Utils.getIconName(iconCode: currentIterationData.iconCode))
        cell.temperatureText.text = Utils.getTemperatureValue(temperature: currentIterationData.temp)        
        let hourToDisplay = currentIterationData.hour
        if hourToDisplay < 24 {
            cell.hourText.text = "\(hourToDisplay):00"
        } else {
            cell.hourText.text = "\(hourToDisplay - 24):00"
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TodayWeatherConditionViewController
        destVC.todayWeatherConditionData = todayWeatherConditionData
    }
    
}
