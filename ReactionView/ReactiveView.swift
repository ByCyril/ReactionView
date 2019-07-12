//
//  ReactionView.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

/// <#Description#>
@objc protocol ReactiveViewDelegate: AnyObject {
    @objc optional func selectedIcon(_ index: Int)
}

/// <#Description#>
///
/// - horizontal: <#horizontal description#>
/// - vertical: <#vertical description#>
/// - blossom: <#blossom description#>
enum PresentationLayout {
    case horizontal
    case vertical
    case blossom
}

/// <#Description#>
///
/// - longPress: <#longPress description#>
/// - tap: <#tap description#>
enum PresentationTrigger {
    case longPress
    case tap
}

/// <#Description#>
///
/// - slide: <#slide description#>
/// - zoom: <#zoom description#>
enum IconAnimationSelectionStyle {
    case slide
    case zoom
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class ReactiveView: ReactiveIconView {
    
//    public properties
    
    /// <#Description#>
    public var popOut: CGFloat = 50
    
    /// <#Description#>
    public var maxScale: CGFloat = 2
    
    /// <#Description#>
    public var iconAnimationSelectionStyle: IconAnimationSelectionStyle? = .slide
    
    /// <#Description#>
    public weak var delegate: ReactiveViewDelegate?

//    typealias
    typealias AnimationBlock = () -> Void
    typealias AnimationCompletionBlock = () -> Void
    
    private weak var target: UIViewController?
    private var actionTarget: NSObject?
    
    private(set) var isDispalyed: Bool = false
    
    private var selectedIndex: Int?
    private var orientation: PresentationLayout!
    private var selectors: [Selector]!
    
    private let longGestureName: String = "longGesture"
    private let tapGestureName: String = "tapGesture"
    private let edgePadding: CGFloat = 15
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - target: <#target description#>
    ///   - iconNames: <#iconNames description#>
    ///   - orientation: <#orientation description#>
    ///   - iconSquareSize: <#iconSquareSize description#>
    override init(target: Any, iconNames: [String], orientation: PresentationLayout, iconSquareSize: CGFloat = 50) {
        if iconSquareSize < 1 {
            super.init(target: target, iconNames: iconNames, orientation: orientation, iconSquareSize: 50)
        } else {
            super.init(target: target, iconNames: iconNames, orientation: orientation, iconSquareSize: iconSquareSize)
        }
        
        self.orientation = orientation
        self.target = target as? UIViewController
    }
    
//    public functions
    
    /// Specifies how and where to present the ReactionView
    ///
    /// - Parameters:
    ///   - button: UIButton?
    ///   - event: .longPress or .tap
    public func present(_ button: UIButton? = nil, event: PresentationTrigger = .longPress) {
        var gesture: UIGestureRecognizer!
        let action = #selector(ReactiveView.dispalyView(_:))
        
        switch event {
        case .longPress:
            gesture = UILongPressGestureRecognizer(target: self, action: action)
            gesture.name = longGestureName
        case .tap:
            gesture = UITapGestureRecognizer(target: self, action: action)
            gesture.name = tapGestureName
        }
        
        if let button = button {
            button.addGestureRecognizer(gesture)
        } else {
            guard let target = self.target else { return }
            target.view.addGestureRecognizer(gesture)
        }
    }
    
    /// Add actions to elements
    ///
    /// - Parameters:
    ///   - target: action target
    ///   - selectors: array of actions
    public func addActions(_ target: Any, selectors: [Selector]) {
        let buttons = self.getButtonElements()
        self.selectors = selectors
        
        self.actionTarget = target as? NSObject
        zip(buttons, selectors).forEach { (button, selector) in
            button.addTarget(target, action: selector, for: .touchUpInside)
        }
    }
    
//    private functions
    @objc
    private func dispalyView(_ gesture: UIGestureRecognizer) {
        guard let target = self.target else { return }
        guard let actionTarget = self.actionTarget else { return }
        
        let centerLocation = gesture.location(in: target.view)
        
        if gesture.name == longGestureName {
            if gesture.state == .began {
                animateIn(centerLocation)
            } else if gesture.state == .ended {
                if let selectedIndex = selectedIndex {
                    if let action = self.selectors[safe: selectedIndex] {
                        actionTarget.perform(action)
                    }
                    delegate?.selectedIcon?(selectedIndex)
                }
                animateOut()
            } else if gesture.state == .changed {
                if self.iconAnimationSelectionStyle == .slide {
                    slideSelectionAnimation(gesture, centerLocation)
                } else if self.iconAnimationSelectionStyle == .zoom {
                    scaledSelectionAnimation(gesture)
                }
                
            }
        } else if gesture.name == tapGestureName {
            isDispalyed ? animateIn(centerLocation) : animateOut()
            isDispalyed = !isDispalyed
        }
        
    }
    
    private func scaledSelectionAnimation(_ gesture: UIGestureRecognizer) {
        let position = gesture.location(in: self)
        let highlightedIcon = self.hoveredElement(point: position)
        
        if highlightedIcon is UIButton {
            self.animation(animation: {
                self.getElements().forEach({ (icon) in
                    icon.transform = .init(scaleX: 0.75, y: 0.75)
                })
                
                self.scaleAnimation(highlightedIcon)
                self.selectedIndex = highlightedIcon?.tag
                
            })
        }
    }
    
    private func slideSelectionAnimation(_ gesture: UIGestureRecognizer, _ centerLocation: CGPoint) {
        guard let target = self.target else { return }
        let viewWidth = target.view.frame.size.width
        let viewHeight = target.view.frame.size.height
        let position = gesture.location(in: self)
        let highlightedIcon = self.hoveredElement(point: position)

        if highlightedIcon is UIButton {
            
            self.animation(animation: {
                self.getElements().forEach({ (icons) in
                    icons.transform = .identity
                })
                
                self.selectedIndex = highlightedIcon?.tag
                
                if self.orientation == .horizontal {
                    self.horizontalIconTransformation(location: centerLocation.y,
                                                      viewHeight: viewHeight,
                                                      element: highlightedIcon)
                } else if self.orientation == .vertical {
                    self.verticalIconTransformation(location: centerLocation.x,
                                                    viewWidth: viewWidth,
                                                    element: highlightedIcon)
                } else if self.orientation == .blossom {
                    
                }
            })
            
        }
    }
    
    private func revertToIdentity() {
        self.getElements().forEach({ (button) in
            button.transform = .identity
        })
    }
    
    private func animateIn(_ location: CGPoint) {
        guard let target = self.target else { return }
        let iconContainerWidth = self.frame.size.width / 2
        let targetWidth = target.view.frame.size.width
        let targetHeight = target.view.frame.size.height
        
        let lowerBound =  iconContainerWidth
        let upperBound = targetWidth - iconContainerWidth

        self.center = location
        self.alpha = 0

        target.view.addSubview(self)
        
        self.animation(animation: {
            self.alpha = 1
            self.xViewTransformation(location.x, upperBound, lowerBound)
            self.yViewTransformation(location.y, targetHeight)
        })
        
    }
    
    private func animateOut() {
        self.animation(animation: {
            self.alpha = 0
        }) {
            self.removeFromSuperview()
            self.revertToIdentity()
        }
    }
    
    private func animation(animation: @escaping AnimationBlock, completion: AnimationCompletionBlock? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            animation()
        }) { (_) in
            if let com = completion?() {
                com
            }
        }
    }
    
    private func scaleAnimation(_ element: UIView?) {
        if let element = element {
            element.transform = CGAffineTransform.identity.scaledBy(x: self.maxScale, y: self.maxScale)
            print(Date())
        }
    }
    
    private func yViewTransformation(_ locationY: CGFloat, _ targetHeight: CGFloat) {
        if locationY < targetHeight * 0.15 {
            if self.orientation == .vertical {
                self.center.y = locationY + self.frame.size.height
            } else {
                self.center.y = locationY + (self.frame.size.height * 1.5)
            }
        } else {
            if self.orientation == .vertical {
                self.center.y = locationY - self.frame.size.height
            } else {
                self.center.y = locationY - (self.frame.size.height * 1.5)
            }
        }
    }
    
    private func xViewTransformation(_ locationX: CGFloat, _ upperBound: CGFloat, _ lowerBound: CGFloat) {
        if locationX > upperBound {
            self.center.x = upperBound - self.edgePadding
        } else if locationX < lowerBound {
            self.center.x = lowerBound + self.edgePadding
        }
    }
    
    private func verticalIconTransformation(location: CGFloat, viewWidth: CGFloat, element: UIView?) {
        if location > viewWidth * 0.05 && location < viewWidth / 2 {
            element?.transform = CGAffineTransform(translationX: popOut, y: 0)
        } else if location > viewWidth / 2 && location < viewWidth * 0.95 {
            element?.transform = CGAffineTransform(translationX: -popOut, y: 0)
        }
    }
    
    private func horizontalIconTransformation(location: CGFloat, viewHeight: CGFloat, element: UIView?) {
        if location > viewHeight * 0.15 {
            element?.transform = CGAffineTransform(translationX: 0, y: -popOut)
        } else {
            element?.transform = CGAffineTransform(translationX: 0, y: popOut)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
