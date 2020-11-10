//
//  PreviewViewController.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 04/11/2020.
//

import UIKit

protocol PreviewDelegate: AnyObject {
    func toggleIconsVisibility(_ flag: Bool)
}

final class PreviewViewController: BaseController<PreviewCoordinator, PreviewViewModel> {
    
    private var previewView: iPhonePreviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator?.delegate = self
        loadPreview()
    }
    
    // MARK: - Layout Configuration
    
    private func loadPreview() {
        previewView = iPhonePreviewView.fromNib()
        precondition(previewView != nil)
        
        previewView.icon = viewModel?.icon
        view.addSubview(previewView)
        previewView.hfix(in: view)
        NSLayoutConstraint.activate([
            previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            previewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    deinit {
        print("PreviewViewController Deinitialized.")
    }
}

// MARK: - Coordinator Delegate Communication

extension PreviewViewController: PreviewDelegate {
    public func toggleIconsVisibility(_ flag: Bool) {
        previewView.setIconsTransparent(flag)
    }
}
