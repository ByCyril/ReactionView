//
//  ViewController.swift
//  ReactionView
//
//  Created by Cyril Garcia on 7/6/19.
//  Copyright © 2019 Cyril Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    var blossomView: UIView!
    var isShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = .white
        
        blossomView = UIView()
        blossomView.frame.size = CGSize(width: 50, height: 50)
        blossomIcons([.green, .yellow, .red, .blue, .magenta, .brown])

//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flow))
//        self.view.addGestureRecognizer(tapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(flow))
        self.view.addGestureRecognizer(longPressGesture)
    }
    
    func blossomIcons(_ iconNames: [UIColor]) {
        iconNames.forEach { (name) in
            let icon = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            icon.backgroundColor = name
            blossomView.addSubview(icon)
        }
    }
    
    @objc
    func flow(_ gesture: UIGestureRecognizer) {

        if gesture.state == .began {
            animateIn(center: gesture.location(in: self.view))
        } else if gesture.state == .ended {
            animateOut()
        }
    }
    
    func animateIn(center: CGPoint) {
        let views = blossomView.subviews as! [UIButton]
        self.blossomView.center = center
        self.blossomView.alpha = 0
        view.addSubview(blossomView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blossomView.alpha = 1
            let d: CGFloat = 100
            
            views[0].transform = CGAffineTransform(translationX: -d, y: 0)
            views[1].transform = CGAffineTransform(translationX: d * -0.5, y: d * -0.8660254038)
            views[2].transform = CGAffineTransform(translationX: d * 0.5, y: d * -0.8660254038)
            views[3].transform = CGAffineTransform(translationX: d, y: 0)
            views[4].transform = CGAffineTransform(translationX: d * 0.5, y: d * 0.8660254038)
            views[5].transform = CGAffineTransform(translationX: d * -0.5, y: d * 0.8660254038)
            
        })
    }
    
    func animateOut() {
        let views = blossomView.subviews as! [UIButton]

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            views.forEach({ (view) in
                view.transform = .identity
            })
            self.blossomView.alpha = 0
        }) { (_) in
            self.blossomView.removeFromSuperview()
        }
    }
  
}

