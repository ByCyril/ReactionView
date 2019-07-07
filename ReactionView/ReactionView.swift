//
//  ReactionView.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

extension ReactionView {
    public func setMainViewController(_ vc: UIViewController) {
        self.vc = vc
    }
}

class ReactionView: IconView {
    
    private weak var vc: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGesture()
        self.setupReactionView()
    }
    
    init(iconNames: [String], orientation: NSLayoutConstraint.Axis, vc: UIViewController) {
        if orientation == .horizontal {
            super.init(frame: CGRect(x: 0, y: 0, width: (iconNames.count * 50) + 5, height: 50))
        } else {
            super.init(frame: CGRect(x: 0, y: 0, width: 50, height: (iconNames.count * 50) + 5))
        }
        self.vc = vc
        self.iconNames = iconNames
        self.addGesture()
        self.setupReactionView(orientation)
    }
    
    private func addGesture() {
        guard let vc = self.vc else { return }
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ReactionView.displayView(_ :)))
        vc.view.addGestureRecognizer(longPress)
    }
    
    @objc
    private func displayView(_ gesture: UIGestureRecognizer) {
        guard let vc = self.vc else { return }
        
        if gesture.state == .began {
            let centerLocation = gesture.location(in: vc.view)
            self.center = CGPoint(x: centerLocation.x, y: centerLocation.y - (self.frame.size.height / 2))
            vc.view.addSubview(self)
        } else if gesture.state == .ended {
            self.removeFromSuperview()
        }
    }

    private func animateIn() {
        
    }
    
    private func animateOut() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
