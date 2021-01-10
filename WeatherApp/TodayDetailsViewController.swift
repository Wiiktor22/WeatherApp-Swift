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
        view.backgroundColor = .red
        
        //collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: "HourlyWeatherCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyWeather", for: indexPath) as! HourlyWeatherCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
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
