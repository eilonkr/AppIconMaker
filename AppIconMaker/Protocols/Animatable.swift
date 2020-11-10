//
//  Animatable.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 08/11/2020.
//

import UIKit

extension UIView: Animatable {} 

protocol Animatable {
    func pulsate(_ flag: Bool)
}

extension Animatable where Self: UIView {
    func pulsate(_ flag: Bool) {
        if flag {
            // Start animating
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.duration = 1.5
            animation.fromValue = 1.0
            animation.toValue = 1.15
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.autoreverses = true
            animation.repeatCount = .infinity
            layer.add(animation, forKey: "scale")
        } else {
            layer.removeAnimation(forKey: "scale")
        }
    }
}
