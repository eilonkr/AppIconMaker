//
//  PreviewCoordinator.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 04/11/2020.
//

import UIKit

class PreviewCoordinator: Coordinator {
    
    weak var delegate: PreviewDelegate?
    
    var navigationController: UINavigationController
    var children = [Coordinator]()
    
    private var icon: UIImage?
    
    private var iconsVisibilityFlag: Bool = false {
        didSet {
            delegate?.toggleIconsVisibility(iconsVisibilityFlag)
        }
    }
    
    private var visibilityIcon: UIImage? {
        UIImage(systemName: iconsVisibilityFlag ? "eye" : "eye.slash")
    }
    
    init(navigationController: UINavigationController, icon: UIImage?) {
        self.navigationController = navigationController
        self.icon = icon
    }
    
    func start() {
        let previewController = PreviewViewController.instantiate()
        previewController.viewModel = PreviewViewModel(icon: icon)
        previewController.coordinator = self
        previewController.navigationItem.rightBarButtonItems = navigationBarItems()
        navigationController.pushViewController(previewController, animated: true)
    }
    
    func iconConfirmed() {
        // Save the icon locally.
        guard let icon = icon else { fatalError("Icon does not exist?") }
        ImageSaver().writeToPhotoAlbum(icon) { [unowned self] in
            endProccess()
        }
    }
    
    private func navigationBarItems() -> [UIBarButtonItem] {
        let toggleButton = UIBarButtonItem(image: visibilityIcon, style: .plain, target: self, action: #selector(toggleVisibilityTapped))
        let doneButton = UIBarButtonItem(systemItem: .save, primaryAction: UIAction { [unowned self] _ in
            iconConfirmed()
        })
        return [doneButton, toggleButton]
    }
    
    private func endProccess() {
        let alert = UIAlertController(title: "Done :)", message: "Icon has been successfully saved to library", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel) { [unowned self] _ in
            navigationController.popViewController(animated: true)
        })
        
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    @objc private func toggleVisibilityTapped(sender: UIBarButtonItem) {
        iconsVisibilityFlag.toggle()
        sender.image = visibilityIcon
    }
    
    deinit {
        print("*PreviewCoordinator* Deinitialized.")
    }
}
