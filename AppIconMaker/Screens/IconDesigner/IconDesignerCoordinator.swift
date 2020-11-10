//
//  IconDesignerCoordinator.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 08/11/2020.
//

import UIKit

class IconDesignerCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController
    var children = [Coordinator]()
    
    public var onFinish: ((UIImage?) -> Void)?
    
    weak var delegate: IconDesignerDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = IconDesignerViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = IconDesignerViewModel()
        navigationController.present(vc, animated: true, completion: nil)
    }
    
    func looksGood() {
        if let image = delegate?.renderIcon() {
            onFinish?(image)
            onFinish = nil
            navigationController.topViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    deinit {
        print("*Icon Designer Coordinator*.")
    }
}

