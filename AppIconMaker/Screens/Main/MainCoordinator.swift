//
//  MainCoordinator.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 03/11/2020.
//

import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController
    
    private lazy var navigationDelegate = NavigationDelegate { [unowned self] coord in
        self.childDidFinish(coord)
    }
    
    private weak var delegate: MainDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = navigationDelegate
        
        let vc = MainViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = MainViewModel()
        delegate = vc
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func shouldEditIcon() {
        let designerCoordinator = IconDesignerCoordinator(navigationController: navigationController)
        children.append(designerCoordinator)
        designerCoordinator.parentCoordinator = self
        designerCoordinator.start()
        designerCoordinator.onFinish = { [unowned self, unowned designerCoordinator] image in
            delegate?.receiveIcon(image)
            self.childDidFinish(designerCoordinator)
        }
    }
    
    func `continue`(with image: UIImage?) {
        if let image = image {
            // Create a new child coordinator.
            let previewCoordinator = PreviewCoordinator(navigationController: navigationController, icon: image)
            children.append(previewCoordinator)
            previewCoordinator.start()
        } else {
            print("No Image Provided.")
            let alert = UIAlertController(title: "😠", message: "Choose an image to continue", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
            navigationController.present(alert, animated: true, completion: nil)
        }
    }
}
