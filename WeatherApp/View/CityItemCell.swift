//
//  CityItemCell.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 23/01/2021.
//

import UIKit

class CityItemCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
