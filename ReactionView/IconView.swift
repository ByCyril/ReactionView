//
//  IconView.swift
//  FBEffect
//
//  Created by Cyril Garcia on 7/1/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

protocol IconViewDelegate: AnyObject {
    func selectedIcon(_ index: Int)
}

class IconView: UIView {
    
    private var spacing: CGFloat = 5.0
    private var iconSize: CGFloat!
    
    public var iconNames = [String]()
    
    private let reactionView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5.0
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupReactionView(_ orientation: NSLayoutConstraint.Axis = .horizontal) {
        if orientation == .vertical {
            reactionView.frame = CGRect(x: 0, y: spacing, width: frame.width, height: frame.height - (spacing * 2))
            iconSize = (frame.height / CGFloat(iconNames.count)) - (spacing * 2)
        } else {
            reactionView.frame = CGRect(x: spacing, y: 0, width: frame.width - (spacing * 2), height: frame.height)
            iconSize = (frame.width / CGFloat(iconNames.count)) - (spacing * 2)
        }
        
        reactionView.axis = orientation
        addSubview(reactionView)
        setIcons()
    }
    
    private func setIcons() {
        iconNames.forEach { (item) in
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: item), for: .normal)
            button.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            button.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            reactionView.addArrangedSubview(button)
        }
    }
}
