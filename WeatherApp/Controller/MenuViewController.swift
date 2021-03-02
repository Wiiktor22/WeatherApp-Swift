//
//  MenuViewController.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 23/01/2021.
//

import UIKit

class MenuViewController: UITableViewController, UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userLocations = [UserLocation]()
    
    @IBOutlet weak var cityNameInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameInput.delegate = self
        fetchUserLocations()
    }
    
    func fetchUserLocations() {
        do {
            try self.userLocations = context.fetch(UserLocation.fetchRequest())
        } catch  {
            print("Error while fetching")
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Search logic
    
    func checkIfTextIsNotEmpty(providedText: String) -> Bool {
        if (providedText.isEmpty) {
            return false
        } else {
            cityNameInput.endEditing(true)
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return checkIfTextIsNotEmpty(providedText: cityNameInput.text!)
    }

    @IBAction func handleSearchPress(_ sender: UIButton) {
        if checkIfTextIsNotEmpty(providedText: cityNameInput.text!) {
            cityNameInput.endEditing(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if checkIfTextIsNotEmpty(providedText: textField.text!) {
            searchCity(city: cityNameInput.text!)
        }
    }
    
    func searchCity(city: String) {
        Geocoding.getGeocodingObject(city: city) { (result: Geocoding?) in
            if (result != nil) {
                let newLocation = UserLocation(context: self.context)
                newLocation.city = result?.name ?? ""
                newLocation.country = result?.country ?? ""
                newLocation.lat = result?.lat ?? 0
                newLocation.lon = result?.lon ?? 0
                
                do {
                    try self.context.save()
                } catch {
                    print("Error while saving")
                }
                
                self.fetchUserLocations()
                
            } else {
                let message = "Nie znaleziono miasta: \(city)"
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true) { [weak self] in
                    self?.cityNameInput.text! = ""
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityItem", for: indexPath) as! CityItemCell
        
        cell.cityNameButton.setTitle(userLocations[indexPath.row].city, for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let locationToRemove = userLocations[indexPath.row]
            
            self.context.delete(locationToRemove)
            do {
                try self.context.save()
            } catch {
                print("Error while deleting")
            }
            
            fetchUserLocations()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chosenCityName = (sender as? UIButton)?.currentTitle ?? nil
        if (chosenCityName != nil) {
            if userLocations.contains(where: { $0.city == chosenCityName }) {
                let chosenLocation = userLocations.first(where: { $0.city == chosenCityName })
                let lat = chosenLocation?.lat ?? 0
                let lon = chosenLocation?.lon ?? 0
                
                let destVC = segue.destination as! LoadingViewController
                destVC.loadWeatherData(lat: lat, lon: lon)
            }
        }
    }
}
