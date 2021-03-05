//
//  UIImageViewExtensions.swift
//  WeatherApp
//
//  Created by Wiktor Szlegier on 05/03/2021.
//

import Foundation
import UIKit

extension UIImageView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.speed = 0.1
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
