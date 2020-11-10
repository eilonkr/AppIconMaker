//
//  AppExtensions.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 04/11/2020.
//

import UIKit

extension CALayer {
    enum ShadowType {
        case regular
    }
    
    func shadow(_ type: ShadowType) {
        switch type {
            case .regular:
                shadowRadius = 8.0
                shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
                shadowOffset = CGSize(width: 0.0, height: 3.0)
                shadowOpacity = 1.0
                shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        }
    }
}


