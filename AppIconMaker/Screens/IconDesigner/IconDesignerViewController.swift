//
//  IconDesignerViewController.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 08/11/2020.
//

import UIKit

protocol IconDesignerDelegate: AnyObject {
    func renderIcon() -> UIImage
}

class IconDesignerViewController: BaseController<IconDesignerCoordinator, IconDesignerViewModel> {

    // MARK: - IBOutlets
    
    @IBOutlet weak var headContainer: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var imageSubContainer: UIView!
    @IBOutlet weak var iconImageContainer: UIView!
    @IBOutlet weak var symbolsCollectionView: UICollectionView!
    @IBOutlet weak var backgroundContainer: ContainerView!
    
    private let delegateAndDataSource = SymbolsDataSource()
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBackgroundContainer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureDesign()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.onFinish?(nil)
    }
    
    // MARK: - Configuration
    
    override func configureFromViewModel() {
        super.configureFromViewModel()
        viewModel?.take(delegateAndDataSource)
        viewModel?.symbol.bind { [unowned self] imageBox in
            self.iconImageView.image = imageBox ?? defaultImage
        }
    }
    
    private func configureDesign() {
        iconImageView.backgroundColor = nil
        headContainer.layer.shadow(.regular)
        
        iconImageContainer.layer.masksToBounds = true
        iconImageContainer.backgroundColor = .systemPink
        iconImageContainer.layer.cornerRadius = iconImageView.frame.height / 4.5
        symbolsCollectionView.layer.cornerRadius = 16.0
    }
    
    private func setupCollectionView() {
        symbolsCollectionView.register(SymbolCell.self, forCellWithReuseIdentifier: "SymbolCell")
        symbolsCollectionView.dataSource = delegateAndDataSource
        symbolsCollectionView.delegate = delegateAndDataSource
    }
    
    private func setupBackgroundContainer() {
        let bgStack = UIStackView()
        bgStack.axis = .horizontal
        bgStack.distribution = .equalCentering
        bgStack.alignment = .center
        bgStack.spacing = 12.0
        bgStack.fix(in: backgroundContainer, padding: .init(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0))
        for bg in GradientPresets.presets {
            let bgObject = BackgroundPickerObject(preset: bg) { [unowned self] preset in
                // Remove the previous background layer
                if imageSubContainer.layer.sublayers?.count ?? -1 > 1 {
                    self.imageSubContainer.layer.sublayers?.removeFirst()
                }
                
                self.imageSubContainer.layer.applyGradient(ofColors: preset)
            }
            
            bgStack.addArrangedSubview(bgObject)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func looksGoodTapped(_ sender: Any) {
        coordinator?.looksGood()
    }
}

extension IconDesignerViewController: IconDesignerDelegate {
    func renderIcon() -> UIImage {
        iconImageContainer.render()
    }
}


