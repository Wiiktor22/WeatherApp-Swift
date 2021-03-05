//
//  WeeklyDetailsViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 09/01/2021.
//

import UIKit

class WeeklyDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var days = [String]()
    var dailyTemperature: [WeeklyTemperatureData]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        days = WeeklyTemperatureData.prepareNamesOfDaysArray()
        
        // TODO: Fix styling issues
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyWeather", for: indexPath) as! DailyWeatherCell
        
        cell.dayOfAWeek.text = days[indexPath.item]
        cell.temperature.text = dailyTemperature[indexPath.item].temp
        cell.weatherIcon.image = UIImage(named: Utils.getIconName(iconCode: dailyTemperature[indexPath.item].iconCode))
        
        // TODO: Check width of the cell
        
        //cell.frame.size.width = UIScreen.main.bounds.width * 0.6
        
        return cell
    }

}
