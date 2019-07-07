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
    
    private let reactionView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5.0
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupReactionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupReactionView() {
        reactionView.frame = CGRect(x: spacing, y: 0, width: frame.width - (spacing * 2), height: frame.height)
        addSubview(reactionView)
    }
    
    public func setIcons(_ iconNames: [String]) {
        let iconSize = (frame.width / CGFloat(iconNames.count)) - (spacing * 2)
        print(iconSize)
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
