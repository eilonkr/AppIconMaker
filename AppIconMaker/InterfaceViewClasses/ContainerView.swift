//
//  ContainerView.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 09/11/2020.
//

import UIKit

class ContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16.0
        layer.shadow(.regular)
    }
    
    private func commonInit() {
        backgroundColor = .tertiarySystemBackground
    }
}
