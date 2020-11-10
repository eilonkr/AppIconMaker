//
//  iPhonePreviewView.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 06/11/2020.
//

import UIKit

class iPhonePreviewView: UIView {
    
    @IBOutlet var defaultIcons: [UIImageView]!
    @IBOutlet weak var iconImageView: UIImageView!
    
    public var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureDesign()
    }
    
    private func configureDesign() {
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 4.5
    }
    
    public func setIconsTransparent(_ flag: Bool) {
        UIView.animate(withDuration: 0.15) {
            self.defaultIcons.forEach {
                $0.alpha = flag ? 0.35 : 1.0
            }
        }
    }
}
