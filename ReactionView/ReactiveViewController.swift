//
//  ReactiveViewController.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/12/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ReactiveView2: UIView {
    
    private let iconContainer: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 5.0
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private var actions:[()->()] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        iconContainer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        addSubview(iconContainer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addAction(title: String?, image: UIImage = UIImage(named: "like")!, handler: @escaping () -> ()) {
        
        let actionButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.setImage(image, for: .normal)
            button.setTitle(title, for: .normal)
            button.tag = self.actions.count
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            self.actions.append(handler)
            return button
        }()
        
        iconContainer.addArrangedSubview(actionButton)
    }
    
    public func present(target: Any) {
        let target = target as! UIViewController
                                
    }
    
    private func displayReactiveView() {
        
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        actions[sender.tag]()
    }
    
    
}
