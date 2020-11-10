//
//  EKButton.swift
//  Altro
//
//  Created by Eilon Krauthammer on 22/05/2020.
//  Copyright © 2020 Eilon Krauthammer. All rights reserved.
//

import UIKit

final class EKButton: UIButton {

    enum `Type`: Int { case regular, compact, freeform }
    
    @IBInspectable public var typeRepresentation: Int = 0 {
        didSet {
            self.type = Type(rawValue: typeRepresentation) ?? .regular
        }
    }
    
    @IBInspectable public var accentColor: UIColor = .systemBlue {
        didSet { backgroundColor = accentColor }
    }
    
    @IBInspectable public var customTitleColor: UIColor? = nil
    
    @IBInspectable public var isInverted: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.backgroundColor = self.isInverted ? .tertiarySystemBackground : self.accentColor
                self.setTitleColor(self.isInverted ? self.accentColor: .white, for: .normal)
                self.tintColor = self.isInverted ? self.accentColor : .white
            }
        }
    }
    
    @IBInspectable public var fontSize: CGFloat = UIFont.systemFontSize + 1
    @IBInspectable public var touchdownTransform: Bool = true
    @IBInspectable public var isSelectable: Bool = false
    @IBInspectable public var customContentInsets: CGFloat = .zero
    
    
    public var shouldBeSelected: Bool = false {
        didSet {
            if isSelectable {
                self.isInverted = !shouldBeSelected
            }
        }
    }
    
    private var type: Type = .regular {
        didSet {
            configureContent()
        }
    }
    
    private var invertedAccentColor: UIColor { .tertiarySystemBackground }
    
    private var highlightFlag = false
    override public var isHighlighted: Bool {
        didSet {
            if touchdownTransform {
                highlightFlag = isHighlighted == oldValue
                if !highlightFlag {
                    UIView.animate(withDuration: 0.15) {
                        self.transform = self.isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
                    }
                }
            }
            
            // See if we want this.
            /*
            if isHighlighted {
                backgroundColor = isInverted ? invertedAccentColor.darker() : accentColor.darker()
            } else {
                backgroundColor = isInverted ? invertedAccentColor : accentColor
            }
            */
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureContent()
    }
    
    private convenience init() {
        self.init(type: .custom)
    }
    
    convenience init(type: Type = .regular, accentColor: UIColor = .systemBlue, title: String = "", icon: UIImage? = nil) {
        self.init()
        self.type = type
        self.accentColor = accentColor
        setTitle(title, for: .normal)
        setImage(icon, for: .normal)
        configureContent()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayer()
    }
    
    // MARK: - Setup
    
    private func configureContent() {
        backgroundColor = isInverted ? .tertiarySystemBackground : accentColor
        setTitleColor(customTitleColor ?? (isInverted ? accentColor: .white), for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        titleLabel?.adjustsFontForContentSizeCategory = true
        adjustsImageWhenHighlighted = false
        tintColor = customTitleColor ?? (isInverted ? accentColor : .white)
        
        let vmargin: CGFloat = 10.0
        
        let hmargin: CGFloat = 12.0
        contentEdgeInsets = customContentInsets != .zero ? .init(top: customContentInsets, left: customContentInsets, bottom: customContentInsets, right: customContentInsets) : (type == .compact ? .init(top: vmargin-2, left: hmargin+3, bottom: vmargin-2, right: hmargin+3) : .init(top: vmargin, left: hmargin, bottom: vmargin, right: hmargin))
        
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    private func configureLayer() {
        layer.cornerRadius = bounds.height / 2
        layer.shadow(.regular)
    }
    
    // MARK: - Interaction
    
    @objc private func didTap() {
        shouldBeSelected.toggle()
    }
    
}
