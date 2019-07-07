//
//  ReactionView.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

protocol ReactionViewDelegate: AnyObject {
    func selectedIcon(_ index: Int?)
}

extension ReactionView {
    public func setMainViewController(_ vc: UIViewController) {
        self.vc = vc
    }
}

class ReactionView: IconView {
    
    public weak var delegate: ReactionViewDelegate?
    
    private weak var vc: UIViewController?
    private var selectedIndex: Int?
    private var orientation: NSLayoutConstraint.Axis!
    
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
        self.orientation = orientation
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
        let centerLocation = gesture.location(in: vc.view)

        if gesture.state == .began {
            animateIn(centerLocation)
        } else if gesture.state == .ended {
            animateOut()
        } else if gesture.state == .changed {
            selecting(gesture, centerLocation)
        }
    }
    
    private func selecting(_ gesture: UIGestureRecognizer, _ centerLocation: CGPoint) {
        guard let vc = self.vc else { return }
        let viewWidth = vc.view.frame.size.width
        let viewHeight = vc.view.frame.size.height
        let position = gesture.location(in: self)
        let element = self.hoveredElement(point: position)
        
        if element is UIButton {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.getElements()?.forEach({ (button) in
                    button.transform = .identity
                })
                self.selectedIndex = element!.tag
                
                if self.orientation == .horizontal {
                    if centerLocation.y > (viewHeight * 0.15) {
                        element?.transform = CGAffineTransform(translationX: 0, y: -50)
                    } else {
                        element?.transform = CGAffineTransform(translationX: 0, y: 50)
                    }
                } else if self.orientation == .vertical {
                    print(centerLocation.x, viewWidth * 0.05, viewWidth / 2)
                    if centerLocation.x > viewWidth * 0.05 && centerLocation.x < viewWidth / 2 {
                        element?.transform = CGAffineTransform(translationX: 50, y: 0)
                    } else if centerLocation.x > viewWidth / 2 && centerLocation.x < viewWidth * 0.95 {
                        element?.transform = CGAffineTransform(translationX: -50, y: 0)
                    }
                }
                
            })
        }
    }

    private func revertToIdentity() {
        self.getElements()?.forEach({ (button) in
            button.transform = .identity
        })
        delegate?.selectedIcon(selectedIndex)
    }
    
    private func animateIn(_ location: CGPoint) {
        guard let vc = self.vc else { return }
        self.center = CGPoint(x: location.x, y: location.y)
        vc.view.addSubview(self)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 1
            self.center.y = location.y - (self.frame.size.height / 2)
        })
    }
    
    private func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
            self.revertToIdentity()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
