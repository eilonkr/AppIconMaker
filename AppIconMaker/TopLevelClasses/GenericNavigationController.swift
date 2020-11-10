//
//  GenericNavigationController.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 03/11/2020.
//

import UIKit

class GenericNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        navigationBar.prefersLargeTitles = true
    }
}
