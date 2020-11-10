//
//  PreviewViewModel.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 06/11/2020.
//

import UIKit

class PreviewViewModel: ViewControllerModel {    
    var navigationTitle = "Preview"
    
    var icon: UIImage
    
    init(icon: UIImage?) {
        self.icon = icon ?? UIImage()
    }
}
