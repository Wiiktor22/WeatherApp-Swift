//
//  Alert.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 05/03/2021.
//

import Foundation
import UIKit

struct Alert {
    
    static func presentOpenLocationSettingsAlert(on vc: UIViewController) {
        let message = "Udostępnij swoją lokalizację, aby pobrać dla niej pogodę i mieć możliwość dodania własnych lokalizacji!"
        let ac = UIAlertController (title: nil, message: message, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Ustawienia", style: .default) { (_) -> Void in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(settingsAction)
        ac.addAction(cancelAction)

        vc.present(ac, animated: true, completion: nil)
    }
    
    static func presentDownloadingErrorAlert(on vc: UIViewController) {
        let message = "Error - podczas pobierania pogody. Spróbuj później!"
        let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(ac, animated: true, completion: nil)
    }
    
    static func presentCoreDataErrorAlert(on vc: UIViewController) {
        let message = "Error - podczas wczytywania pamięci aplikacji."
        let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(ac, animated: true, completion: nil)
    }
}
