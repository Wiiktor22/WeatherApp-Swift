//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 06/01/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var todayDetailsContainer: UIView!
    @IBOutlet var weeklyDetailsContainer: UIView!
    var subviews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailsSubviews()
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
