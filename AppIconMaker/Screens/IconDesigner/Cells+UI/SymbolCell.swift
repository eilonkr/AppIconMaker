//
//  SymbolCell.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 08/11/2020.
//

import UIKit

class SymbolCell: UICollectionViewCell {
    
    public var isChosen: Bool = false {
        didSet {
            setChosen()
        }
    }
    
    private var imageView: UIImageView = {
        let iv = UIImageView(image: nil)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var symbol: UIImage! {
        didSet { imageView.image = symbol }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    private func configureLayout() {
        contentView.addSubview(imageView)
        imageView.center(in: contentView)
        imageView.constraintAspectRatio(1.0, width: 30.0)
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setChosen() {
        UIView.animate(withDuration: 0.15) {
            self.backgroundColor = self.isChosen ? .tertiarySystemFill : .clear
        }
    }
    
    public func provide(_ symbolName: String) {
        self.symbol = UIImage(systemName: symbolName)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
