//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 06/01/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var detailsContainer: UIView!
    @IBOutlet var todayDetailsContainer: UIView!
    @IBOutlet var weeklyDetailsContainer: UIView!
    var subviews = [UIView]()

    @IBOutlet weak var cityAndCountryLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var actualTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    var cityAndCountryText: String! = nil
    var weatherDescriptionText: String! = nil
    var actualTemperatureText: String! = nil
    var minTemperatureText: String! = nil
    var maxTemperatureText: String! = nil
    var iconCode: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsContainer.layer.cornerRadius = 15
        configureDetailsSubviews()
        
        setValuesIntoLabels()
        currentWeatherIcon.image = UIImage(named: iconCode)
    }
    
    func setValuesIntoLabels() {
        cityAndCountryLabel.text = cityAndCountryText
        weatherDescriptionLabel.text = weatherDescriptionText
        actualTemperatureLabel.text = actualTemperatureText
        minTemperatureLabel.text = minTemperatureText
        maxTemperatureLabel.text = maxTemperatureText
    }
    
    func configureDetailsSubviews() {
        subviews = [todayDetailsContainer, weeklyDetailsContainer]
        hideAllSubviews()
        subviews[0].isHidden = false
    }
    
    func hideAllSubviews() {
        for subview in subviews {
            subview.isHidden = true
        }
    }
    
    @IBAction func didDetailsSegmentChange(_ sender: UISegmentedControl) {
        hideAllSubviews()
        subviews[sender.selectedSegmentIndex].isHidden = false
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
