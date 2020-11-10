//
//  ViewController.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 03/11/2020.
//

import UIKit

let defaultImage = UIImage(systemName: "photo.on.rectangle.angled")!

protocol MainDelegate: AnyObject {
    func receiveIcon(_ icon: UIImage?)
}

class MainViewController: BaseController<MainCoordinator, MainViewModel> {
    
    // MARK: - IBOutlets

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewContainer: UIView!
    
    // MARK: - Life Cycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFromViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureDesign()
    }

    // MARK: - Configuration
    
    override func configureFromViewModel() {
        super.configureFromViewModel()
        setupBinding()
        imageView.superview?.pulsate(true)
    }
    
    private func configureDesign() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = viewModel?.cornerRadius(for: imageViewContainer.frame.width) ?? 0.0
        imageViewContainer.layer.shadow(.regular)
        imageViewContainer.layer.cornerRadius = viewModel?.cornerRadius(for: imageViewContainer.frame.width) ?? 0.0
    }
    
    private func setupBinding() {
        viewModel?.icon.bind { [unowned self] icon in
            if icon != nil {
                imageViewContainer.backgroundColor = nil
            }
            
            self.imageView.image = icon ?? defaultImage
        }
    }
    
    // MARK: - Actions :: Coordinator interactions
    
    @IBAction func imageViewTapped(_ sender: Any) {
        coordinator?.shouldEditIcon()
    }
    
    @IBAction func exportTapped(_ sender: Any) {
        guard let viewModel = viewModel else {
            print("No View Model.")
            return
        }

        coordinator?.continue(with: viewModel.icon.value)
    }
}

extension MainViewController: MainDelegate {
    func receiveIcon(_ icon: UIImage?) {
        viewModel?.icon.value = icon ?? defaultImage
    }
}


//extension MainViewController: MainViewModelDelegate {
//    func receiveIcon(_ icon: UIImage) {
//        self.imageView.image = icon
//    }
//}


