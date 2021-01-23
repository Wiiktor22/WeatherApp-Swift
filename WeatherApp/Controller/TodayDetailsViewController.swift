//
//  TodayDetailsViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 09/01/2021.
//

import UIKit

class TodayDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeather", for: indexPath) as! HourlyWeatherCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.weatherIcon.image = UIImage(named: "clouds")
        cell.temperatureText.text = "-- °C"
        
        let actualHour = Calendar.current.component(.hour, from: Date())
        let hourToDisplay = actualHour + indexPath.item + 1
        
        if hourToDisplay < 24 {
            cell.hourText.text = "\(hourToDisplay):00"
        } else {
            cell.hourText.text = "\(hourToDisplay - 24):00"
        }
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
