//
//  IconView.swift
//  FBEffect
//
//  Created by Cyril Garcia on 7/1/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class IconView: UIView {
    
    private let iconStackView = UIStackView()

    public var stackSpacing: CGFloat = 5
    public var stackAxis: NSLayoutConstraint.Axis = .horizontal
    public var stackDistribution: UIStackView.Distribution = .equalSpacing
    public var stackAlignment: UIStackView.Alignment = .center
    
    private var iconNamesArray = ["like", "dislike", "funny", "interesting", "offensive"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(iconNamesArray: [String], frame: CGRect) {
        super.init(frame: frame)
        self.iconNamesArray = iconNamesArray
        iconStackViewSetup()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    private func iconStackViewSetup() {
        let width = frame.size.width
        let height = frame.size.height
        
        iconStackView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        iconStackView.distribution = stackDistribution
        iconStackView.alignment = stackAlignment
        iconStackView.spacing = stackSpacing
        addSubview(iconStackView)
    }
    
    public func setIconNamesArray(_ iconNamesArray: [String]) {
        if iconNamesArray.count < 6 {
            self.iconNamesArray = iconNamesArray
        } else {
            fatalError("Max 5 icons")
        }
    }
    
    public func setup() {
  
        let iconSize = (frame.size.width / CGFloat(iconNamesArray.count)) - 5
        
        iconNamesArray.forEach { (image) in
            let button = UIButton()
            button.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
            button.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
            button.setImage(UIImage(named: image)!, for: .normal)
            iconStackView.addArrangedSubview(button)
        }
        
    }
    
}
