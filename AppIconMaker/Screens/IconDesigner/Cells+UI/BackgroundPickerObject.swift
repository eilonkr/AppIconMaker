//
//  BackgroundPickerObject.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 09/11/2020.
//

import UIKit

class BackgroundPickerObject: UIView {
    var backgroundPreset: [UIColor]
    
    private var onSelect: ([UIColor]) -> Void
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 44.0, height: 44.0)
    }
    
    public init(preset: [UIColor], handler: @escaping ( [UIColor]) -> Void) {
        self.backgroundPreset = preset
        self.onSelect = handler
        super.init(frame: .zero)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect)))
        
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = bounds.height / 2
        layer.applyGradient(ofColors: backgroundPreset)
    }
    
    @objc private func didSelect() {
        onSelect(self.backgroundPreset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
