//
//  UIView+Rendering.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 10/11/2020.
//

import UIKit

extension UIView {
    func render() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        
        // Reset corner radius if any
        let originalCornerRadius = layer.cornerRadius
        layer.cornerRadius = 0.0
        
        // Render the image
        let image = renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        
        // Set back corner radius
        layer.cornerRadius = originalCornerRadius
        
        return image
    }
}
