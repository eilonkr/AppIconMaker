//
//  GradientPresets.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 09/11/2020.
//

import UIKit

struct GradientPresets {
    static let presets: [[UIColor]] = [
        [UIColor.systemBlue, UIColor.systemRed],
        [UIColor.systemTeal, UIColor.systemIndigo],
        [UIColor.systemRed, UIColor.systemOrange],
        [UIColor.systemGreen, UIColor.systemBlue],
        [UIColor.systemPink, UIColor.systemBlue]
    ]
}

extension CALayer {
    func applyGradient(ofColors colors: [UIColor], ltr: Bool = false, atIndex index: Int? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        
        // Diagonal
        gradientLayer.startPoint = .init(x: 0.0, y: 0.0)
        gradientLayer.endPoint =   .init(x: 1.0, y: 1.0)
        insertSublayer(gradientLayer, at: UInt32(index ?? 0))
    }
}

