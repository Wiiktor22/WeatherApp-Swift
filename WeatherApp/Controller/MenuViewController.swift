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
        
        cell.cityName.text = userLocations[indexPath.row].city

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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
