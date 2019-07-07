//
//  ReactionView.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ReactionView: IconView {
    
    private weak var vc: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    init(iconNames: [String], orientation: NSLayoutConstraint.Axis, vc: UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: (iconNames.count * 50) + 5, height: 50))
        self.vc = vc
        self.setIcons(iconNames)
        self.addGesture()
    }
    
    private func addGesture() {
        guard let vc = self.vc else { return }
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ReactionView.test(_ :)))
        vc.view.addGestureRecognizer(longPress)
    }
    
    @objc
    private func test(_ gesture: UIGestureRecognizer) {
        guard let vc = self.vc else { return }
        
        if gesture.state == .began {
            let centerLocation = gesture.location(in: vc.view)
            self.center = CGPoint(x: centerLocation.x, y: centerLocation.y - (self.frame.size.height / 2))
            vc.view.addSubview(self)
        } else if gesture.state == .ended {
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
