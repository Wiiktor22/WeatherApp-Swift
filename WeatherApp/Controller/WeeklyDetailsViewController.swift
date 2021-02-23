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
        defineDaysArray()
        
        // TODO: Fix styling issues
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func defineDaysArray() {
        let day = Calendar.current.component(.weekday, from: Date())
        
        for i in 0...6 {
            var numberOfTheDay = day + i + 1
            if numberOfTheDay > 7 {
                numberOfTheDay -= 7
            }
            days.append(getNameOfTheDay(numberOfTheDay))
        }
    }
    
    func getNameOfTheDay(_ day: Int) -> String {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyWeather", for: indexPath) as! DailyWeatherCell
        
        cell.dayOfAWeek.text = days[indexPath.item]
        cell.temperature.text = dailyTemperature[indexPath.item].temp
        cell.weatherIcon.image = UIImage(named: getIconName(iconCode: dailyTemperature[indexPath.item].iconCode))
        
        // TODO: Check width of the cell
        
        //cell.frame.size.width = UIScreen.main.bounds.width * 0.6
        
        return cell
    }

}
