//
//  IconView.swift
//  FBEffect
//
//  Created by Cyril Garcia on 7/1/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit 

class ReactiveIconView: UIView {
    
//    public properties
    public var iconBackgroundColor: UIColor?
    public var iconCornerRadius: CGFloat?

    private(set) var iconContainerFrame: CGRect!
    
    private var spacing: CGFloat = 5.0
    private var iconSize: CGFloat!
    
    private let iconContainer: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5.0
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(target: Any, iconNames: [String], orientation: PresentationLayout, iconSquareSize: CGFloat) {
       
        if orientation == .horizontal {
            super.init(frame: CGRect(x: 0, y: 0,
                                     width: (CGFloat(iconNames.count) * iconSquareSize) + 5,
                                     height: iconSquareSize))
            iconContainer.frame = CGRect(x: spacing, y: 0,
                                         width: frame.width - (spacing * 2),
                                         height: frame.height)
            iconSize = (frame.width / CGFloat(iconNames.count)) - (spacing * 2)
        } else if orientation == .vertical {
            super.init(frame: CGRect(x: 0, y: 0,
                                     width: iconSquareSize,
                                     height: (CGFloat(iconNames.count) * iconSquareSize) + 5))
            iconContainer.frame = CGRect(x: 0, y: spacing,
                                         width: frame.width,
                                         height: frame.height - (spacing * 2))
            iconSize = (frame.height / CGFloat(iconNames.count)) - (spacing * 2)
        } else {
            super.init(frame: CGRect(x: 0, y: 0, width: iconSquareSize, height: iconSquareSize))
            iconSize = iconSquareSize
        }
        
        self.iconContainerFrame = iconContainer.frame
        
        switch orientation {
        case .horizontal:
            self.iconContainer.axis = .horizontal
            addSubview(iconContainer)
            self.setIcons(iconNames)
        case .vertical:
            self.iconContainer.axis = .vertical
            addSubview(iconContainer)
            self.setIcons(iconNames)
        case .blossom:
            self.blossomIcons(iconNames)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func blossomIcons(_ iconNames: [String]) {
        iconNames.forEach { (name) in
            let icon = UIButton(frame: self.frame)
            icon.setImage(UIImage(named: name), for: .normal)
            icon.backgroundColor = iconBackgroundColor ?? .clear
            icon.layer.cornerRadius = iconCornerRadius ?? 0
            icon.tag = self.subviews.count
            addSubview(icon)
        }
    }
    
    private func setIcons(_ iconNames: [String]) {
        iconNames.forEach { (name) in
            let icon = UIButton()
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.setImage(UIImage(named: name), for: .normal)
            icon.backgroundColor = iconBackgroundColor ?? .clear
            icon.layer.cornerRadius = iconCornerRadius ?? 0
            icon.tag = iconContainer.arrangedSubviews.count
            icon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            icon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            iconContainer.addArrangedSubview(icon)
        }
    }

    public func hoveredElement(point: CGPoint) -> UIView? {
        return iconContainer.hitTest(point, with: nil)
    }
    
    public func getElements() -> [UIView] {
        return iconContainer.subviews
    }
    
    public func getButtonElements() -> [UIButton] {
        return iconContainer.subviews as! [UIButton]
    }
}
